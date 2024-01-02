class Post < ApplicationRecord
  belongs_to :user
  belongs_to :fish
  belongs_to :aquarium
end
