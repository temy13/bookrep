class CreateTwitterUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_users do |t|
      t.integer :user_id
      t.string :tweets
      t.integer :followers_count
      t.integer :friends_count
      t.integer :favolites_count
      t.string :description
      t.string :screen_name
      t.string :uid
      t.datetime :last_tweet
      t.boolean :get_friends, :default => false

      t.timestamps
    end
  end
end
