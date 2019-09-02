require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:taro)
  end

  # サイトレイアウトに関するテスト（トップページ、ユーザー登録ページ、ログインページ、ユーザー一覧ページ）
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", use_of_terms_path
    get login_path
    assert_template 'sessions/new'
    assert_select "a[href=?]", signup_path
    get signup_path
    assert_template 'users/new'
    assert_select "a[href=?]", use_of_terms_path
    # index(ユーザー一覧)ページのレイアウト（ログイン〜ログアウト）
    log_in_as(@user)
    get users_path
    assert_template "users/index"
    assert_select "a[href=?]", root_url
    assert_select "a[href=?]", user_path(@user)
    delete logout_path  # logout_pathにDELETEリクエストを送りつける
    assert_not is_logged_in?
    get users_path
    assert_not flash.empty?
    assert_redirected_to login_path
  end

end
