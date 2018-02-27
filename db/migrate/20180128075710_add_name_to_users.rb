class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    # add_column :users, :name, :string
    change_column :users, :name, :string, :null => true
    change_column :users, :screen_name, :string, :null => true

  end
end
