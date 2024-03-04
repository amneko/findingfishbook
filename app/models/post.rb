# frozen_string_literal: true

# Post
class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader

  attr_accessor :post_image_cache

  belongs_to :user
  belongs_to :fish
  belongs_to :aquarium
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :fish_id, presence: true
  validates :aquarium_id, presence: true

  # fish_idに基づいてPostを取得するscope
  scope :with_fish, ->(fish_id) { where(fish_id: fish_id) }

  # 特定のfish_idを持つPostからユニークなaquarium_idを取得するscope
  scope :aquariums_with_fish, ->(fish_id) {
    with_fish(fish_id).includes(:aquarium).select(:aquarium_id).distinct
  }

  # aquarium_idに基づいてPostを取得するscope
  scope :with_aquarium, ->(aquarium_id) { where(aquarium_id: aquarium_id) }

  # 特定のaquarium_idを持つPostからユニークなfish_idを取得するscope
  scope :fishes_in_aquarium, ->(aquarium_id) {
    with_aquarium(aquarium_id).includes(:fish).select(:fish_id).distinct
  }
end
