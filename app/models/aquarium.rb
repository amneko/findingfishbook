class Aquarium < ApplicationRecord
  geocoded_by :name
  after_validation :geocode, if: :address_changed?
  belongs_to :prefecture
  has_many :posts

  def self.ransackable_attributes(auth_object = nil)
    %w[name prefecture_id]
  end
end
