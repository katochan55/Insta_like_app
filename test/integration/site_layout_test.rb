require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # トップページのサイトレイアウトに関するテスト
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
  end

end