class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "ユーザー登録しました"
    else
      flash.now[:alert] = "登録に失敗しました。ユーザーIDが重複していないか確認してください。"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:uid, :password, :password_confirmation)
  end
end