require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael) # fixture で用意したユーザー
    @other_user = users(:archer) # もう一人のユーザー
    log_in_as(@user) # テスト用ログインヘルパー
    @user.follow(@other_user)
  end

  test "home page displays stats" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "section.stats" do
      assert_select "a[href=?]", following_user_path(@user), text: @user.following.count.to_s
      assert_select "a[href=?]", followers_user_path(@user), text: @user.followers.count.to_s
    end
  end
end