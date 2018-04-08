class ChangePushNotice < ActiveRecord::Migration[5.1]
  def change
    remove_column :push_notifications, :Endpoint, :string
    add_column :push_notifications, :endpoint, :string
    change_column :push_notifications, :is_notice, :boolean, :default => true
  end
end
