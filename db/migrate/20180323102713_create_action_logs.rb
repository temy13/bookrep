class CreateActionLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :action_logs do |t|
      t.string :request_method
      t.integer :user_id
      t.string :path_info

      t.timestamps
    end
  end
end
