class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader
  attr_accessor :post_image_cache
  belongs_to :user
  belongs_to :fish
  belongs_to :aquarium
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
end
