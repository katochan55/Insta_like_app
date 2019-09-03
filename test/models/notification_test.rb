require 'test_helper'

class NotificationTest < ActiveSupport::TestCase

  def setup
    @notification = Notification.new(user_id: users(:taro).id,
                                     content: "Hello")
  end

  test "should be valid" do
    assert @notification.valid?
  end

  # user_idは存在すべき
  test "should require a user_id" do
    @notification.user_id = nil
    assert_not @notification.valid?
  end
  
  # contentは存在すべき
  test "should require a content" do
    @notification.content = nil
    assert_not @notification.valid?
  end

end
