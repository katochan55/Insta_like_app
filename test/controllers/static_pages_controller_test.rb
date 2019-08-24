require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Instagram"
  end
  
  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get terms" do
    get use_of_terms_url
    assert_response :success
    assert_select "title", "利用規約・#{@base_title}"
  end

end
