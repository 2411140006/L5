require "test_helper"

class TweetTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      uid: "tweet-test-user",
      password: "secret",
      password_confirmation: "secret"
    )
    @tweet = Tweet.create!(user: @user, message: "Hello")
  end

  test "like creates one like and liked? reports it" do
    assert_difference("Like.count", 1) { @tweet.like(@user) }

    assert @tweet.liked?(@user)
    assert_no_difference("Like.count") { @tweet.like(@user) }
  end

  test "unlike removes the like" do
    @tweet.like(@user)

    assert_difference("Like.count", -1) { @tweet.unlike(@user) }

    assert_not @tweet.liked?(@user)
    assert_nothing_raised { @tweet.unlike(@user) }
  end

  test "destroying a tweet destroys its likes" do
    @tweet.like(@user)

    assert_difference("Like.count", -1) { @tweet.destroy }
  end
end
