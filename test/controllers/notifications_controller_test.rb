require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:taro)
  end
  
  # 通知一覧ページを表示するには、ログインしていることが必要
  test "notification index should require logged-in user" do
    get notifications_path
    assert_redirected_to login_url
  end
  
end