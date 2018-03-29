class CreateAmazonTmpLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :amazon_tmp_links do |t|
      t.string :title
      t.integer :node_id
      t.integer :click_count, :default => 0

      t.timestamps
    end
  end
end
