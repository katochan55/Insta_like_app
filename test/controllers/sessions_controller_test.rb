require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title1 = "Instagram"
  end
  
  test "should get login" do
    get login_url
    assert_response :success
    assert_select "title", "ログイン・#{@base_title1}"
  end

end
