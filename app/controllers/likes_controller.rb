
class LikesController < ApplicationController
  before_action :require_login

  def create
    tweet = Tweet.find(params[:tweet_id])

    tweet.like(current_user)

    redirect_to root_path, notice: "いいねしました"
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])

    tweet.unlike(current_user)

    redirect_to root_path, notice: "いいねを削除しました"
  end

  private

  def require_login
    redirect_to login_path unless current_user
  end
end
