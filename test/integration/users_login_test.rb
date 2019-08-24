require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:taro)
  end

  # 無効なユーザーでログイン
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  # 有効なユーザーでログイン
  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    #assert_select "a[href=?]", '#' -> indexページへのリンク
    #assert_select "a[href=?]", user_path(@user)
    #assert_select "a[href=?]", 通知一覧 後ほど追加
  end
  
end