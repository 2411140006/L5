class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      redirect_to user_profile_path(@user), notice: "プロフィールを更新しました"
    else
      flash.now[:alert] = @user.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end

  def set_user
    @user = current_user
  end

  def profile_params
    params.require(:user).permit(:age, :bio)
  end
end
