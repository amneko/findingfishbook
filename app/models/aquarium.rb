class Aquarium < ApplicationRecord
  belongs_to :prefecture
  has_many :posts
end
