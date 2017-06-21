class StylePhotosController < ApplicationController
  before_action :set_style_photo, only: [:show, :edit, :update, :destroy]

  # GET /style_photos
  # GET /style_photos.json
  def index
    @style_photos = StylePhoto.all
  end

  # GET /style_photos/1
  # GET /style_photos/1.json
  def show
  end

  # GET /style_photos/new
  def new
    @style_photo = StylePhoto.new
  end

  # GET /style_photos/1/edit
  def edit
  end

  # POST /style_photos
  # POST /style_photos.json
  def create
    @style_photo = StylePhoto.new(style_photo_params)

    respond_to do |format|
      if @style_photo.save
        format.html { redirect_to @style_photo, notice: 'style photo was successfully created.' }
        format.json { render :show, status: :created, location: @style_photo }
      else
        format.html { render :new }
        format.json { render json: @style_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /style_photos/1
  # PATCH/PUT /style_photos/1.json
  def update
    respond_to do |format|
      if @style_photo.update(style_photo_params)
        format.html { redirect_to @style_photo, notice: 'style photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @style_photo }
      else
        format.html { render :edit }
        format.json { render json: @style_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /style_photos/1
  # DELETE /style_photos/1.json
  def destroy
    @style_photo.destroy
    respond_to do |format|
      format.html { redirect_to style_photos_url, notice: 'style photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style_photo
      @style_photo = StylePhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def style_photo_params
      params.require(:style_photo).permit(:style_id, :image)
    end
end
