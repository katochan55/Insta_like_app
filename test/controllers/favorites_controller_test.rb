require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @favorite     = favorites(:one)
    @micropost_id = @favorite.micropost_id
    @user_id = @favorite.user_id
  end

  # お気に入りをcreate(登録)するには、ログインしていることが必要
  test "create should require logged-in user" do
    assert_no_difference 'Favorite.count' do
      post "/favorites/#{@micropost_id}/create"
    end
    assert_redirected_to login_url
  end

  # お気に入りを削除(解除)するには、ログインしていることが必要
  test "destroy should require logged-in user" do
    assert_no_difference 'Favorite.count' do
      delete "/favorites/#{@micropost_id}/destroy"
    end
    assert_redirected_to login_url
  end
  
end