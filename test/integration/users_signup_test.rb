require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_response :unprocessable_entity
    assert_template 'users/new'
    
    # エラーメッセージの表示確認
    assert_select 'div#error_explanation'  # エラーを囲むdivのid
    assert_select 'div.field_with_errors'  # フォームのエラークラス

    # 特定のエラーメッセージが含まれるか
    assert_select 'div#error_explanation', /Name can't be blank/
    assert_select 'div#error_explanation', /Email is invalid/
    assert_select 'div#error_explanation', /Password is too short/
  end
end
