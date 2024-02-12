# frozen_string_literal: true

# Fish
class Fish < ApplicationRecord
  mount_uploader :image, FishImageUploader

  attr_accessor :image_cache

  belongs_to :location
  has_many :north_appearances, dependent: :destroy
  has_many :posts

  validates :name, presence: true
  validates :location_id, presence: true
  validates :selling_price_tanuki, presence: true
  validates :selling_price_justin, presence: true
end
