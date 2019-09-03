class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validate  :picture_size
  has_many :comments, dependent: :destroy
  
  # 引数のmicropost_idを持つコメントを集めてくる
  def feed_comment(micropost_id)
    Comment.where("micropost_id = ?", micropost_id)
  end

  private
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MBより大きい画像はアップロードできません。")
      end
    end
    
end