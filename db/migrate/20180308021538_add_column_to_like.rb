class AddColumnToLike < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :like, :bool,null: false, default: false
  end
end
