class ChangeColumnToMouldDetails < ActiveRecord::Migration
  def change
    remove_column :mould_details, :is_idle
    add_column :mould_details, :is_idle, :string, :default => ""
  end
end
