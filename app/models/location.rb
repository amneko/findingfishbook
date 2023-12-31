class Location < ApplicationRecord
  has_many :fish, dependent: :destroy
end
