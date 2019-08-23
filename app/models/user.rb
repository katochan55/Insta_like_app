class User < ApplicationRecord
  before_save { self.email = self.email.downcase }  # 保存する直前にemail属性を小文字に変換してメールアドレスの一意性を保証する
  validates :full_name, presence: true, length: { maximum:  50 }
  validates :user_name, presence: true, length: { maximum:  50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  # 有効なメールアドレスの正規表現
  validates :email,     presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
