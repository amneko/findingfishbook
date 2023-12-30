class Fish < ApplicationRecord
  belongs_to :location
  has_many :north_appearances, dependent: :destroy
end
