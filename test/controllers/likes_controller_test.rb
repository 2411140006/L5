require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      uid: "likes-controller-user",
      password: "secret",
      password_confirmation: "secret"
    )
    @tweet = @user.tweets.create!(message: "Hello")
  end

  test "create and destroy use the current user and tweet methods" do
    sign_in

    assert_difference("Like.count", 1) do
      post tweet_like_path(@tweet)
    end
    assert_redirected_to root_path
    assert @tweet.reload.liked?(@user)

    assert_no_difference("Like.count") do
      post tweet_like_path(@tweet)
    end

    assert_difference("Like.count", -1) do
      delete tweet_like_path(@tweet)
    end
    assert_redirected_to root_path
    assert_not @tweet.reload.liked?(@user)
  end

  test "requires login to like a tweet" do
    post tweet_like_path(@tweet)

    assert_redirected_to login_path
    assert_not @tweet.likes.exists?
  end

  private

  def sign_in
    post login_path, params: { uid: @user.uid, password: "secret" }
    assert_redirected_to root_path
  end
end
