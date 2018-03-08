class CreateTitleQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :title_queries do |t|
      t.integer :user_id
      t.string :query

      t.timestamps
    end
  end
end
