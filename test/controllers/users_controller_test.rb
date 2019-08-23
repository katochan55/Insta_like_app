require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Instagram clone"
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "ユーザー登録 | #{@base_title}"
  end
  
  test "should get login" do
    get login_url
    assert_response :success
    assert_select "title", "ログイン | #{@base_title}"
  end
  
end
