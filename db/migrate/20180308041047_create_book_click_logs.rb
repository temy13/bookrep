class CreateBookClickLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :book_click_logs do |t|
      t.integer :user_id
      t.integer :answer_id
      t.integer :book_id

      t.timestamps
    end
  end
end
