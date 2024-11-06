class AddColumnMessageToNotifications < ActiveRecord::Migration[7.2]
  def change
    add_column :notifications, :message, :text
  end
end
