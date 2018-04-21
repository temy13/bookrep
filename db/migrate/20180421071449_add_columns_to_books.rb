class AddColumnsToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :google_description, :string
    add_column :books, :vector_json, :string
  end
end
