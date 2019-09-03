require 'test_helper'

class NotificationsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:taro)
  end
  
  test "notifications index page" do
    log_in_as(@user)
    notification = @user.notifications.create(content: "あなたの投稿が#{@user.full_name}さんにお気に入り登録されました。")
    get notifications_path
    assert_match notification.content, response.body
  end
  
end
