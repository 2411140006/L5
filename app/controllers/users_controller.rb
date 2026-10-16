def create
  @user = User.new(user_params)

  if @user.save
    session[:user_id] = @user.id
    redirect_to root_path, notice: "ユーザー登録しました"
  else
    flash.now[:alert] = @user.errors.full_messages.join("、")
    render :new, status: :unprocessable_entity
  end
end