require "test_helper"

class MicropostsInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
end

class ImageUploadTest < MicropostsInterface

  # **画像アップロード用の input タグがあるかをテスト**
  test "should have a file input field for images" do
    get root_path
    assert_select 'input[type=file]'
  end

  # **画像が正しくアップロードされるかをテスト**
  test "should be able to attach an image" do
    cont = "This micropost really ties the room together."
    img = fixture_file_upload(Rails.root.join('test/fixtures/files/kitten.jpg'), 'image/jpeg')

    # マイクロポストを投稿
    post microposts_path, params: { micropost: { content: cont, image: img } }

    # 投稿されたマイクロポストを取得
    micropost = assigns(:micropost)

    # **画像が正しく添付されているかを確認**
    assert micropost.image.attached?
  end
end
