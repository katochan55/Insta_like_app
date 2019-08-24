module ApplicationHelper
  
  # ページごとの完全なタイトルを返す
  def full_title(title1 = '', title2 = '')
    base_title1 = "Instagram"
    base_title2 = "Instagram写真と動画"
    if title1.empty? && title2.empty?
      base_title1
    elsif title2.empty?
      "#{title1}・#{base_title1}"
    elsif title1.present? && title2.present?
      "#{title1}さん(@#{title2})・#{base_title2}"
    end
  end
  
end
