require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # サイトレイアウトに関するテスト（トップ、ユーザー登録、ログイン）
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path  # ログイン前はヘッダー非表示にしたら削除
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", use_of_terms_path
    get login_path
    assert_select "a[href=?]", root_path  # ログイン前はヘッダー非表示にしたら削除
    assert_select "a[href=?]", signup_path
    get signup_path
    assert_select "a[href=?]", root_path  # ログイン前はヘッダー非表示にしたら削除
    assert_select "a[href=?]", use_of_terms_path
  end

end
