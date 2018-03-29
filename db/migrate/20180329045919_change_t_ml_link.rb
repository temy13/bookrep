class ChangeTMlLink < ActiveRecord::Migration[5.1]
  def change
    change_column :amazon_tmp_links, :node_id, :integer, limit: 8
  end
end
