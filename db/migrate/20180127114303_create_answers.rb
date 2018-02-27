class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.string :content, :null => false
      t.integer :book_id
      t.string :title, :null => false

      t.timestamps
    end
  end
end
