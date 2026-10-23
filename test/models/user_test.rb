require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires matching password confirmation" do
    user = User.new(
      uid: "confirmation-test-user",
      password: "secret",
      password_confirmation: "different"
    )

    assert_not user.valid?
    assert user.errors.of_kind?(:password_confirmation, :confirmation)
  end

  test "requires password confirmation" do
    user = User.new(uid: "missing-confirmation-user", password: "secret")

    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "can't be blank"
  end

  test "destroying a user destroys their tweets and likes" do
    user = User.create!(
      uid: "dependent-test-user",
      password: "secret",
      password_confirmation: "secret"
    )
    tweet = user.tweets.create!(message: "Hello")
    other_user = User.create!(
      uid: "dependent-test-other-user",
      password: "secret",
      password_confirmation: "secret"
    )
    Like.create!(user: user, tweet: tweet)
    Like.create!(user: other_user, tweet: tweet)

    assert_difference("Tweet.count", -1) do
      assert_difference("Like.count", -2) { user.destroy }
    end
  end
end
