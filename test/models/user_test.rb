require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(full_name: "山田 太郎",
                     user_name: "Example User",
                         email: "user@example.com",
                      password: "foobar",
         password_confirmation: "foobar")
  end

  # 有効なユーザーである
  test "should be valid" do
    assert @user.valid?
  end
  
  # フルネームが存在する
  test "full_name should be present" do
    @user.full_name = "     "
    assert_not @user.valid?
  end
  
  # ユーザーネームが存在する
  test "user_name should be present" do
    @user.user_name = "     "
    assert_not @user.valid?
  end
  
  # メールアドレスが存在する
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  # フルネームが50文字以内である
  test "full_name should not be too long" do
    @user.full_name = "a" * 51
    assert_not @user.valid?
  end

  # ユーザーネームが50文字以内である
  test "user_name should not be too long" do
    @user.user_name = "a" * 51
    assert_not @user.valid?
  end

  # メールアドレスが255文字以内である
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  # 有効なメールアドレスが許諾される
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  # 無効なメールアドレスが拒絶される
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  # メールアドレスが一意であること（大文字、小文字の違いがあっても一意でないとする）
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  # メールアドレスは小文字に変換され保存されること
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  # 空ではないパスワードが設定されていること
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  # パスワードは最低6文字以上であること
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  # ダイジェストが存在しない場合にはauthenticated?はfalseになること
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
  
  # ユーザーが破棄されたとき、マイクロポストも同様に破棄されること(dependent: :destroyのテスト)
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  
  # following関連のメソッド(follow, unfollow)
  test "should follow and unfollow a user" do
    taro = users(:taro)
    jiro  = users(:jiro)
    assert_not taro.following?(jiro)
    taro.follow(jiro)
    assert taro.following?(jiro)
    taro.unfollow(jiro)
    assert_not taro.following?(jiro)
  end

end
