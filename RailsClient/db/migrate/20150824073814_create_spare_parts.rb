class CreateSpareParts < ActiveRecord::Migration
  def change
    create_table :spare_parts do |t|
      t.datetime :record_date
      t.string :mould_id, :null => false
      t.string :project_id, :default => ""
      t.string :spare_type, :default => ""
      t.string :spare_kind, :default => ""
      t.string :broken_state, :default => ""
      t.string :maintainman
      t.integer :qty
      t.string :machine_id
      t.string :outbound_id

      t.timestamps null: false
    end

    add_index :spare_parts, :mould_id
    add_index :spare_parts, :project_id
  end
end
