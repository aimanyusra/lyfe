class ImagesController < ApplicationController
  before_action :set_event

  def create
    add_more_images(images_params)
    flash[:error] = "Failed uploading images" unless @event.save
    redirect_to :back
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @event.save
    redirect_to :back
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def add_more_images(new_images)
    images = @event.images 
    images += new_images
    @event.images = images
  end

  def remove_image_at_index(index)
    remain_images = @event.images # copy the array
    deleted_image = remain_images.delete_at(index) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @event.images = remain_images # re-assign back
  end

  def images_params
    params.require(:event).permit({images: []}) # allow nested params as array
  end
end