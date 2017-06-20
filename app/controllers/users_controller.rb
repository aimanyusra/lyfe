class UsersController < Clearance::UsersController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			redirect_to 'users#show'
		else
			# @user.save
			# respond_to do |format|
			# 	format.html {render template: "user/new"}
			# 	format.js
			# end
			render template: "users/new"
		end
	end

	def index
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		respond_to do |format|
		if @user.update(user_params)
		 format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
  	end
	end

	def show
		@user = User.find(params[:id])
		@events = Event.where(host_id: @user.id)
		@eventusers = EventUser.where(user_id: @user.id)
		@favorites = Favorite.where(user_id: @user.id)
		@fav_event = @favorites.where(object: 'event')
		@fav_style = @favorites.where(object: 'style')
	end

	# google calendar permission request
	def redirect
    client = Signet::OAuth2::Client.new({
      client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    })

    redirect_to client.authorization_uri.to_s
  end

	def callback
		client = Signet::OAuth2::Client.new({
			client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
			token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
			redirect_uri: callback_url,
			code: params[:code]
		})

		response = client.fetch_access_token!
		session[:authorization] = response
		redirect_to calendars_url
	end

	def calendars
    client = Signet::OAuth2::Client.new({
			client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
    })

    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    begin
      @calendar_list = service.list_calendar_lists
    	rescue Google::Apis::AuthorizationError => exception
      response = client.refresh!

      session[:authorization] = session[:authorization].merge(response)

      retry
    end
  end

	def gevents
    client = Signet::OAuth2::Client.new({
			client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
    })

    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    byebug
    @event_list = service.list_events(params[:calendar_id])
  end

	def new_gevent
    client = Signet::OAuth2::Client.new({
			client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
    })

    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    today = Date.today

    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
      end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
      summary: 'Almost there'
    })

    service.insert_event(current_user.email, event)

    redirect_to events_url(calendar_id: current_user.email)
  end

	# freebusy checker
	def freebusy
	  client = init_client
	  service = client.discovered_api('calendar', 'v3')
	  @result = client.execute(
	    :api_method => service.freebusy.query,
	    :body_object => { :timeMin => start_time, #example: DateTime.now - 1.month
	                      :timeMax => end_time, #example: DateTime.now + 1.month
	                      :items => items
	                    })
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :age, :email, :password, :gender, :avatar, :remove_avatar)
	end
end
