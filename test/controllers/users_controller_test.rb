require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title1 = "Instagram"
    @base_title2 = "Instagram写真と動画"
    @user = users(:taro)
    @other_user = users(:jiro)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "登録・#{@base_title1}"
  end
  
  test "should get show" do
    get user_path(@user)
    assert_response :success
    assert_select "title", "#{@user.full_name}さん(@#{@user.user_name})・#{@base_title2}"
  end
  
  # editアクションはログインしていない時にリダイレクトされるべき(before_action :logged_in_userに対するテスト)
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # updateアクションはログインしていない時にリダイレクトされるべき(before_action :logged_in_userに対するテスト)
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { full_name: @user.full_name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  # 本人以外がログインしてeditアクションを実行した場合、リダイレクトされるべき(before_action :correct_userに対するテスト)
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  # 本人以外がログインしてupdateアクションを実行した場合、リダイレクトされるべき(before_action :correct_userに対するテスト)
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { full_name: @user.full_name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
end
