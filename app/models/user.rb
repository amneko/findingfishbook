class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :like_fish, length: { maximum: 30 }
  validates :like_aquarium, length: { maximum: 30 }

  enum role: { general: 0, admin: 1 }
end
