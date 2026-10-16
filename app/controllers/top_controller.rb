
class TopController < ApplicationController
  def main
    @tweets = Tweet.includes(:user, :likes).order(created_at: :desc)
  end
end

