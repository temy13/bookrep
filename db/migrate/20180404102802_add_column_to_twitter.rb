class AddColumnToTwitter < ActiveRecord::Migration[5.1]
  def change
    add_column :hash_tweets, :twitter_id, :integer, limit: 8
    change_column :twitter_users, :share_count, :integer, :default => 0
    change_column :twitter_users, :is_follow, :boolean, :default => false
  end
end
