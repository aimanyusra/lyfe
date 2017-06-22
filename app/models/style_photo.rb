class StylePhoto < ApplicationRecord
	mount_uploader :image, StyleUploader

	belongs_to :style
end
