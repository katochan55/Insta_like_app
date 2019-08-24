require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title1 = "Instagram"
    @base_title2 = "Instagram写真と動画"
    @user = users(:taro)
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
  
end
