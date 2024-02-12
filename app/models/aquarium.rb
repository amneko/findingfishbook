# frozen_string_literal: true

# Aquarium
class Aquarium < ApplicationRecord
  geocoded_by :name
  after_validation :geocode, if: :address_changed?
  belongs_to :prefecture
  has_many :posts

  validates :name, :prefecture_id, :address, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name prefecture_id]
  end
end
