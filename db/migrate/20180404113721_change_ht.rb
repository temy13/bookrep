class ChangeHt < ActiveRecord::Migration[5.1]
  def change
    remove_column :hash_tweets, :twitter_id, :string
    remove_column :hash_tweets, :twitter_id_str, :string
    add_column :hash_tweets, :tweet_id, :integer, :limit => 8
  end
end
