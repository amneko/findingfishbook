class Fish < ApplicationRecord
  mount_uploader :image, FishImageUploader
  attr_accessor :image_cache
  belongs_to :location
  has_many :north_appearances, dependent: :destroy
  has_many :posts
end
