require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title1 = "Instagram"
    @base_title2 = "Instagram写真と動画"
    @user = users(:taro)
    @other_user = users(:jiro)
  end
  
  # indexアクションはログインしていない時にリダイレクトされるべき(before_action :logged_in_userに対するテスト)
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
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
  
  # admin属性の変更が禁止されていること
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { password: @other_user.password,
                                                    password_confirmation: @other_user.password,
                                                    admin: 1 } }
    assert_not @other_user.reload.admin? # reloadでデータベース内のデータを読み込み直す
  end
  
  # ログインせずにdestroyアクションを実行した場合、リダイレクトされるべき(before_action :correct_userに対するテスト)
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  # 管理者以外のログインしたユーザーがdestroyアクションを実行した場合、リダイレクトされるべき(before_action :admin_userに対するテスト)
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  
end
