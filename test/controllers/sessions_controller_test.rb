require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      uid: "sessions-controller-user",
      password: "secret",
      password_confirmation: "secret"
    )
  end

  test "shows two password fields on the login page" do
    get login_path

    assert_response :success
    assert_select 'input[type="password"]', count: 2
  end

  test "logs in when the password and confirmation match" do
    post login_path, params: {
      uid: @user.uid,
      password: "secret",
      password_confirmation: "secret"
    }

    assert_redirected_to root_path
    assert_equal @user.id, session[:user_id]
  end

  test "does not log in when the password and confirmation differ" do
    post login_path, params: {
      uid: @user.uid,
      password: "secret",
      password_confirmation: "different"
    }

    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end
end
