require 'test_helper'

class FavoritesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:taro)
    @other = users(:jiro)
    log_in_as(@user)
    @micropost = Micropost.last
  end
  
  # トップページ、マイページ、他のユーザのマイページから、マイクロポストのお気に入り登録と解除が可能
  test "should favorite and unfavorite micropost" do
    # トップページ
    get root_url
    assert_template 'static_pages/home'
    assert_not @user.favorite?(@micropost)
    @user.favorite(@micropost)
    assert @user.favorite?(@micropost)
    @user.unfavorite(@micropost)
    assert_not @user.favorite?(@micropost)
    # マイページ
    get user_path(@user)
    assert_template 'users/show'
    @micropost = @user.microposts.last
    assert_not @user.favorite?(@micropost)
    @user.favorite(@micropost)
    assert @user.favorite?(@micropost)
    @user.unfavorite(@micropost)
    assert_not @user.favorite?(@micropost)   
    # 他のユーザのマイページ
    get user_path(@other)
    assert_template 'users/show'
    @micropost = @other.microposts.last
    assert_not @user.favorite?(@micropost)
    @user.favorite(@micropost)
    assert @user.favorite?(@micropost)
    @user.unfavorite(@micropost)
    assert_not @user.favorite?(@micropost)   
  end

  # スタンダードな方法でマイクロポストをお気に入り登録＆解除
  test "should favorite a micropost the standard way" do
    assert_difference '@user.favorites.count', 1 do
      @user.favorite(@micropost)
    end
    assert_difference '@user.favorites.count', -1 do
      @user.unfavorite(@micropost)
    end
  end

  # Ajaxでマイクロポストをお気に入り登録＆解除
  test "should favorite a micropost with Ajax" do
    assert_difference 'Favorite.count', 1 do
      post "/favorites/#{@micropost.id}/create", xhr: true
    end
    assert_difference 'Favorite.count', -1 do
      delete "/favorites/#{@micropost.id}/destroy", xhr: true
    end
  end

end