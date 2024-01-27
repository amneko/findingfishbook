# frozen_string_literal: true

# Location
class Location < ApplicationRecord
  has_many :fish, dependent: :destroy
end
