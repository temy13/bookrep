class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :question_id
      t.string :name
      t.string :uid, :null => true

      t.timestamps
    end
  end
end
