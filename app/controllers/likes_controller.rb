
class LikesController < ApplicationController
  before_action :require_login

  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user = User.find(session[:user_id])

    current_user.likes.find_or_create_by(tweet: tweet)

    redirect_to root_path, notice: "いいねしました"
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    current_user = User.find(session[:user_id])

    current_user.likes.find_by(tweet: tweet)&.destroy

    redirect_to root_path, notice: "いいねを削除しました"
  end

  private

  def require_login
    redirect_to login_path unless session[:user_id]
  end
end
