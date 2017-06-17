class EventPhotosController < ApplicationController
  before_action :set_event_photo, only: [:show, :edit, :update, :destroy]

  # GET /event_photos
  # GET /event_photos.json
  def index
    @event_photos = EventPhoto.all
  end

  # GET /event_photos/1
  # GET /event_photos/1.json
  def show
  end

  # GET /event_photos/new
  def new
    @event_photo = EventPhoto.new
  end

  # GET /event_photos/1/edit
  def edit
  end

  # POST /event_photos
  # POST /event_photos.json
  def create
    @event_photo = EventPhoto.new(event_photo_params)

    respond_to do |format|
      if @event_photo.save
        format.html { redirect_to @event_photo, notice: 'Event photo was successfully created.' }
        format.json { render :show, status: :created, location: @event_photo }
      else
        format.html { render :new }
        format.json { render json: @event_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_photos/1
  # PATCH/PUT /event_photos/1.json
  def update
    respond_to do |format|
      if @event_photo.update(event_photo_params)
        format.html { redirect_to @event_photo, notice: 'Event photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_photo }
      else
        format.html { render :edit }
        format.json { render json: @event_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_photos/1
  # DELETE /event_photos/1.json
  def destroy
    @event_photo.destroy
    respond_to do |format|
      format.html { redirect_to event_photos_url, notice: 'Event photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_photo
      @event_photo = EventPhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_photo_params
      params.require(:event_photo).permit(:event_id, :image)
    end
end
