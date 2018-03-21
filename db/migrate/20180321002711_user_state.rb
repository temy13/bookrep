class UserState < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :states_cd, :integer, default: 0
  end
end
