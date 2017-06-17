class EventPhoto < ApplicationRecord
	mount_uploader :image, EventPhotoUploader

	belongs_to :event
end
