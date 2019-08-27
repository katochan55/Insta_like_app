class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token
  before_save :downcase_email  # 保存する直前にemail属性を小文字に変換してメールアドレスの一意性を保証する
  validates :full_name, presence: true, length: { maximum:  50 }
  validates :user_name, presence: true, length: { maximum:  50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  # 有効なメールアドレスの正規表現
  validates :email,     presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  
  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    
    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
    
    
  # 永続セッションのためにユーザーをデータベースに保存する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?  # remember_digestがnilだった場合は事前にfalseを返し、BCrypt::Passwordでnilを読み込んでエラーになることを避ける
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  private
  
    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase # 右辺のself.は省略
    end
  
end
