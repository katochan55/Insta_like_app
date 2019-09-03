require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper # full_titleヘルパーを使用するため

  def setup
    @user = users(:taro)
  end

  # プロフィール画面の表示
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.full_name, @user.user_name)
    assert_match @user.user_name, response.body
    assert_select 'img.gravatar'
    assert edit_user_path(@user)
    assert logout_path, method: :delete
    assert_match @user.full_name, response.body
    assert_match @user.introduction, response.body unless @user.introduction.nil?
  end
end