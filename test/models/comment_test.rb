require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @comment = Comment.new(micropost_id: users(:jiro).microposts.first.id,
                           user_id: users(:taro).id,
                           content: "Hello")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  # micropost_idは存在すべき
  test "should require a micropost_id" do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end

  # user_idは存在すべき
  test "should require a user_id" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  # micropost_idは存在すべき
  test "should require a content" do
    @comment.content = ""
    assert_not @comment.valid?
  end
  
end
