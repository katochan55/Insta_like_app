require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  # full_titleヘルパーの単体テスト
  test "full title helper" do
    assert_equal full_title, "Instagram clone"
  end

end