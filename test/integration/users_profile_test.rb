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
    assert_select 'h1', text: @user.user_name
    assert_select 'h1>img.gravatar'
  end
end