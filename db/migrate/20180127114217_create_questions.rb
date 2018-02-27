class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :content, :null => false
      t.integer :twitter_share_count, :default => 0
      t.boolean :is_anonymous, :default => false

      t.timestamps
    end
  end
end
