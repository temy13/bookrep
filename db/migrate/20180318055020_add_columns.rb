class AddColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :subtitle, :string
    add_column :books, :google_categories, :string

    add_column :questions, :score, :integer, default: 0
    add_column :answers, :score, :integer, default: 0

  end
end
