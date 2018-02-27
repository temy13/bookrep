class UserddColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :icon_path, :string
    add_column :users, :is_email_notice, :boolean, :default => false
  end
end
