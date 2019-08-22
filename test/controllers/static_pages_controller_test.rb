require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Instagram clone"
  end
  
  test "should get root" do
    get root_path
    assert_response :success
  end
  
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "トップ | #{@base_title}"
  end

  test "should get terms" do
    get static_pages_terms_url
    assert_response :success
    assert_select "title", "利用規約 | #{@base_title}"
  end

end
