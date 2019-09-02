require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  
  def setup
    @favorite = Favorite.new(user_id: users(:taro).id,
                                     micropost_id: users(:jiro).microposts.first.id)
  end

  test "should be valid" do
    assert @favorite.valid?
  end

  # user_idは存在すべき
  test "should require a user_id" do
    @favorite.user_id = nil
    assert_not @favorite.valid?
  end

  # micropost_idは存在すべき
  test "should require a micropost_id" do
    @favorite.micropost_id = nil
    assert_not @favorite.valid?
  end
  
end
