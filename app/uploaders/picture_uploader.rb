class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # 600 * 600の正方形に整形
  process resize_and_pad(600, 600, background = :transparent, gravity = 'Center')
  
  # if Rails.env.production?
  #   storage :fog
  # else
  #   storage :file
  # end
  
  storage :file
  
  # アップロードファイルの保存先ディレクトリは上書き可能
  # 下記はデフォルトの保存先  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロード可能な拡張子のリスト
  def extension_whitelist
    %w(jpg jpeg png)
  end
end