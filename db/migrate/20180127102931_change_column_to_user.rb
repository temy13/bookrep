class ChangeColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :screen_name, :string, :null => false
    add_column :users, :name, :string, :null => false
    add_column :users, :profile, :string

  end
end
