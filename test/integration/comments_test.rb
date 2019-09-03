require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:taro)
    @micropost = Micropost.first # フィードの一番上に表示されるマイクロポスト
  end
  
  # トップページのコメントUIとコメント投稿
  test "comment interface in root_url" do
    log_in_as(@user)
    get root_path
    assert_select 'input[type=submit]'
    assert_select 'textarea#comment_content'
    # ここからコメント投稿
    content = "Hello"
    post comments_path, params: { micropost_id: @micropost.id,
                                  comment: { content: content } }
    follow_redirect!
    assert_not flash.empty?
    assert_match "#{content}", response.body
    assert_match "#{@user.user_name}", response.body
  end

end
