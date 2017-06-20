class Tag < ApplicationRecord
	has_many :event_tags, dependent: :destroy
  	has_many :events, through: :event_tags

  	has_many :style_tags, dependent: :destroy
  	has_many :styles, through: :style_tags
end
