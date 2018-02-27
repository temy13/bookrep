class AddIsAnonymousToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :is_anonymous, :bool, :default => false
  end
end
