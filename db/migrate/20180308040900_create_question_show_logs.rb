class CreateQuestionShowLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :question_show_logs do |t|
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
