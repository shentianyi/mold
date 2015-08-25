class AddColumnToKnifeSwitchRecord < ActiveRecord::Migration
  def change
    add_column :knife_switch_records, :terminal_leoni_id, :string, :default => ""
  end
end
