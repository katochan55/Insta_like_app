class AddIndexToNotificationsContent < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :content, :text
  end
end
