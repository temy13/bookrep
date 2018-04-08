class AddColumnToPushNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :push_notifications, :p256dh, :string
    add_column :push_notifications, :auth, :string
  end
end
