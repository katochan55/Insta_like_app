require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:orange)
    @user      = users(:taro)
  end
  
  # コメントをnew(作成)するには、ログインしていることが必要
  test "new should require logged-in user" do
    get new_comment_path
    assert_redirected_to login_url
  end

  # コメントをcreate(登録)するには、ログインしていることが必要
  test "create should require logged-in user" do
    post comments_path, params: { comment: { micropost_id: @micropost.id,
                                             user_id: @user.id,
                                             content: "Hello" } }
    assert_redirected_to login_url
  end
  
end