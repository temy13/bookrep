class CreateHashTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :hash_tweets do |t|
      t.integer :user_id
      t.string :uid
      t.string :twitter_id_str
      t.string :content
      t.datetime :posted

      t.timestamps
    end
  end
end
