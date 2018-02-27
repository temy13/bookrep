class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn10
      t.string :isbn13
      t.string :asin
      t.string :google_books_id

      t.timestamps
    end
  end
end
