require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    
    # ✅ flashメッセージが表示されるか確認
    assert_not flash.empty?  # flashにメッセージが入っているか
    
    # ✅ flashメッセージが表示されるHTML要素があるか確認
    assert_select 'div.alert-success', "Welcome to the Sample App!"
  end
end
