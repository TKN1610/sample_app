require "test_helper"

class Following < ActionDispatch::IntegrationTest
  def setup
    @user  = users(:michael)  # fixturesのユーザー
    @other = users(:archer)   # 別のユーザー
    log_in_as(@user)          # ログイン処理
  end
end

class FollowPagesTest < Following
  test "feed on Home page" do
    get root_path
    @user.feed.paginate(page: 1).each do |micropost|
      assert_match CGI.escapeHTML(micropost.content), response.body
    end
  end
end
