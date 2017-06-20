class Event < ApplicationRecord
	has_many :event_users
	has_many :users, through: :event_users

	has_many :event_tags
	has_many :users, through: :event_tags

	has_many :event_photos
end


