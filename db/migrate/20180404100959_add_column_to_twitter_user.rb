class AddColumnToTwitterUser < ActiveRecord::Migration[5.1]
  def change
    add_column :twitter_users, :is_follow, :boolean
    add_column :twitter_users, :share_count, :integer
  end
end
