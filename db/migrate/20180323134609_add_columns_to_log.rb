class AddColumnsToLog < ActiveRecord::Migration[5.1]
  def change
    add_column :action_logs, :remote_ip, :string
    add_column :action_logs, :ip, :string
    add_column :users, :score, :integer, :default => 0


  end
end
