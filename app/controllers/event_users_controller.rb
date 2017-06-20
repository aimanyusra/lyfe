class EventUsersController < ApplicationController
	def show
		EventUser.create(event_id: params[:id], user_id: current_user.id)
		# if user = auth?
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
			summary: 'working???!'
		})

		service.insert_event(current_user.email, event)

		redirect_to events_url(calendar_id: current_user.email)

		# redirect_to events_path
	end
	# used show because it has /:id as params
	# looks like no need strong params if not using form_for

	def destroy
		@attendence = EventUser.where(event_id: params[:id])
		@attendence = @attendence.where(user_id: current_user.id)
		@attendence[0].destroy
		redirect_to events_path
	end

	def edit
		# just using this for making favorites
		byebug
	end

	def update
		Favorite.create(user_id: current_user.id, object: 'event', objectid: params[:id])
		redirect_to events_path
	end
end
