require 'test_helper'

class NotificationsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user              = users(:taro)
    @other             = users(:jiro)
    @my_micropost      = microposts(:orange)
    @my_micropost_2    = microposts(:cat_video)
    @other_micropost   = microposts(:ants)
    @other_micropost_2 = microposts(:zone)
  end
  
  # 通知一覧ページ
  test "notifications index page" do
    log_in_as(@user)
    # 通知がcreateされると通知一覧ページに通知文が表示される
    notification = @user.notifications.create(micropost_id: @my_micropost.id,
                                              content: "あなたの投稿が#{@user.full_name}さんにお気に入り登録されました。")
    get notifications_path
    assert_match notification.content, response.body
    # 自分の投稿がお気に入り登録されたとき、自分への通知が1増える
    assert_difference '@user.notifications.count', 1 do
      post "/favorites/#{@my_micropost.id}/create", xhr: true
    end
    # 自分の投稿がお気に入り登録されたとき、他人への通知は増えない
    assert_no_difference '@other.notifications.count' do
      post "/favorites/#{@my_micropost_2.id}/create", xhr: true
    end
    # 他人の投稿がお気に入り登録されたとき、自分への通知は増えない
    assert_no_difference '@user.notifications.count' do
      post "/favorites/#{@other_micropost.id}/create", xhr: true
    end
    # 他人の投稿がお気に入り登録されたとき、その他人への通知が1増える
    assert_difference '@other.notifications.count', 1 do
      post "/favorites/#{@other_micropost_2.id}/create", xhr: true
    end
    # 自分の投稿がコメントされたとき、自分への通知が1増える
    assert_difference '@user.notifications.count', 1 do
      post comments_path, params: { micropost_id: @my_micropost.id,
                                    comment: { content: "Hello" } }
    end
    # 自分の投稿がコメントされたとき、他人への通知は増えない
    assert_no_difference '@other.notifications.count' do
      post comments_path, params: { micropost_id: @my_micropost.id,
                                    comment: { content: "Hello" } }
    end
    # 他人の投稿がコメントされたとき、自分への通知は増えない
    assert_no_difference '@user.notifications.count' do
      post comments_path, params: { micropost_id: @other_micropost.id,
                                    comment: { content: "Hello" } }
    end
    # 他人の投稿がコメントされたとき、その他人への通知は1増える
    assert_difference '@other.notifications.count', 1 do
      post comments_path, params: { micropost_id: @other_micropost.id,
                                    comment: { content: "Hello" } }
    end
  end
  
end
