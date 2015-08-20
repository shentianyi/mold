class CreateKnifeSwitchSlices < ActiveRecord::Migration
  def change
    create_table :knife_switch_slices do |t|
      t.string :mould_id, :null => false
      t.string :project_id, :default => ""
      t.string :terminal_leoni_id, :default => ""
      t.datetime :switch_date
      t.string :knife_type1, :default => ""
      t.string :knife_type2, :default => ""
      t.string :wire_type, :default => ""
      t.float :wire_cross
      t.string :image_after, :default => ""
      t.string :image_before, :default => ""
      t.string :is_ok, :default => ""
      t.string :email, null: false, default: "mj@leoni.com"

      t.timestamps null: false
    end

    add_index :knife_switch_slices, :mould_id
  end
end
