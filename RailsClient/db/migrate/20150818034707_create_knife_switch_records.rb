class CreateKnifeSwitchRecords < ActiveRecord::Migration
  def change
    create_table :knife_switch_records do |t|
      t.string :mould_id, :null => false
      t.string :project_id, :default => ""
      t.datetime :switch_date
      t.string :knife_type, :default => ""
      t.string :knife_kind, :default => ""
      t.string :knife_supplier, :default => ""
      t.string :state, :default => ""
      t.string :problem, :default => ""
      t.string :damage_define, :default => ""
      t.string :maintainman, :default => ""
      t.integer :qty, :default => 1
      t.integer :m_qty, :default => 0
      t.string :machine_id, :default => ""
      t.integer :press_num, :default => 0
      t.integer :damage_life, :default => 0
      t.integer :broken_life, :default => 0
      t.integer :total_life, :default => 0

      t.string :operater, :default => ""
      t.string :is_ok, :default => ""
      t.string :sort, :default => ""
      t.string :outbound_id, :default => ""
      t.string :image_id, :default => ""
      t.string :email, null: false, default: "mj@leoni.com"

      t.timestamps null: false
    end

    add_index :knife_switch_records, :mould_id
    add_index :knife_switch_records, :image_id
  end
end
