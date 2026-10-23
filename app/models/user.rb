class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_tweets, source: :tweet, through: :likes

  has_secure_password

  validates :uid, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, if: -> { password.present? }
end
