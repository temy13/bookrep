class AddTokenToPushNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :push_notifications, :firebase_token, :string
  end
end
