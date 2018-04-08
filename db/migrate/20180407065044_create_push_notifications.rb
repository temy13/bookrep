class CreatePushNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :push_notifications do |t|
      t.integer :user_id
      t.string :Endpoint
      t.boolean :is_notice

      t.timestamps
    end
  end
end
