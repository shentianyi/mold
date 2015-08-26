class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_edit, :boolean, :default => false
    add_column :users, :can_delete, :boolean, :default => false
  end
end
