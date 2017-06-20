class Style < ApplicationRecord
  belongs_to :user

  has_many :style_tags
  has_many :tags, through: :style_tags
end
