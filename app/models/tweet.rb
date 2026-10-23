class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, source: :user, through: :likes

  def like(user)
    likes.find_or_create_by(user: user)
  end

  def unlike(user)
    likes.find_by(user: user)&.destroy
  end

  def liked?(user)
    like_users.include?(user)
  end
end
