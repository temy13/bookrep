class AddColumnToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :is_tweet, :bool, :default => false
  end
end
