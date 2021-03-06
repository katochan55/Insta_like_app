require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:taro)
  end

  # ログイン後のトップページのUI
  test "micropost interface at root_path" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:jiro))
    assert_select 'a', text: '削除', count: 0
  end
  
  # サイドバーのマイクロポストの投稿数
  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body
    # まだマイクロポストを投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "A micropost")
    get root_path
    assert_match "1 micropost", response.body
  end
  
  # マイクロポスト投稿ページのUI
  test "micropost interface at new_micropost_path" do
    log_in_as(@user)
    get new_micropost_path
    assert_select 'input[type=file]'
    # 無効な送信
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This micropost really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost:
                                      { content: content,
                                        picture: picture } }
    end
    # show(個別投稿)ページのUI
    assert assigns(:micropost).picture? # 投稿成功後にassignsメソッドでインスタンス変数@micropostにアクセス
    assert_template 'show'
    assert_match content, response.body
    assert_select 'input[type=submit]'
    assert_select 'textarea#comment_content'
    # コメント投稿
    content_comment = "Hello"
    post comments_path, params: { micropost_id: assigns(:micropost).id,
                                  comment: { content: content_comment } }
    follow_redirect!
    assert_not flash.empty?
    assert_match "#{content}", response.body
    assert_match "#{@user.user_name}", response.body
  end
  
end