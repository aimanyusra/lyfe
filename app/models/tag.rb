class Tag < ApplicationRecord
	has_many :event_tags
  	has_many :events, through: :event_tags

  	has_many :style_tags
  	has_many :styles, through: :style_tags
end
