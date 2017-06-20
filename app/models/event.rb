class Event < ApplicationRecord
	has_many :event_users, dependent: :destroy
	has_many :users, through: :event_users

	has_many :event_tags, dependent: :destroy
	has_many :tags, through: :event_tags, dependent: :destroy

	has_many :event_photos
end


