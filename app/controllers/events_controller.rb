class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    if current_user
      @joined_event = []
      @joined = EventUser.where(user_id: current_user.id)
      @joined.each do |x|
        @joined_event << Event.find(x.event_id)
      end

      @events = []
      @joined_event_id = []
      @joined.each do |y|
          @joined_event_id << y.event_id
        end
      Event.all.each do |x|
        if @joined_event_id.include? x.id
          # do nothing
        else

          @events << x
        end
      end
    end
      respond_to do |format|
      format.json
      format.html
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @joined = EventUser.where(event_id:params[:id]).count

    @event = Event.find(params[:id])
    @event_photos = @event.event_photos.all
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create

    @event = Event.new(event_params)

   tag_array = event_params['tags'].split(',')
   tag_array.each do |x|
     @event.tags << x
     @tag = Tag.create(desc: x)
     EventTag.create(event_id: @event.id, tag_id: @tag.id)
   end

   # add event to google calendar
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
     summary: 'Final Lyfe act!'
   })

   service.insert_event(current_user.email, event)

   redirect_to events_url(calendar_id: current_user.email)

   respond_to do |format|
     if @event.save
       params[:event]['images'].each do |a|
         @event_photo = @event.event_photos.create!(:image => a, :event_id => @event.id)
       end
       format.html { redirect_to @event, notice: 'Event was successfully created.' }
       format.json { render :show, status: :created, location: @event }
     else
       format.html { render :new }
       format.json { render json: @event.errors, status: :unprocessable_entity }
     end
   end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :status, :description, :start_date, :end_date, :location, :time, :age_limit, :price, :host_id, :tags, event_photos_attributes: [:id, :event_id, :image])
    end

    def store_photos
        photos = params[:event][:images]
        photos.each{|photo| @event.event_photos.create(image: photo)} if photos
    end
end
