class Aquarium < ApplicationRecord
  geocoded_by :name
  after_validation :geocode, if: :address_changed?
  belongs_to :prefecture
  has_many :posts
end
