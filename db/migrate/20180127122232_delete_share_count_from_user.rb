class DeleteShareCountFromUser < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :is_tweet, :bool, :default => false
    remove_column :questions, :twitter_share_count
  end
end
