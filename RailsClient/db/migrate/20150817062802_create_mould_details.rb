class CreateMouldDetails < ActiveRecord::Migration
  def change
    create_table :mould_details do |t|
      t.string :mould_id, :null => false
      t.string :mould_type, :default => ""
      t.string :mould_state, :default => ""
      t.string :mould_supplier, :default => ""
      t.string :position, :default => ""
      t.string :terminal_leoni_no, :default => ""
      t.string :terminal_supplier, :default => ""
      t.string :stopwater, :default => ""
      t.string :use_range, :default => ""
      t.string :wire_type, :default => ""
      t.float :wire_cross
      t.string :original_param_ch, :default => "NO"
      t.string :original_param_cw, :default => "NO"
      t.string :actual_param_ch, :default => "NO"
      t.string :actual_param_cw, :default => "NO"
      t.string :actual_param_ich, :default => "NO"
      t.string :actual_param_icw, :default => "NO"
      t.string :step_dch_id, :default => "/"
      t.string :step_ich_id, :default => "/"
      t.datetime :next_time
      t.string :c_up_knife, :default => ""
      t.string :i_up_knife, :default => ""
      t.string :c_down_knife, :default => ""
      t.string :i_down_knife, :default => ""
      t.string :upper_punch, :default => ""
      t.string :coc, :default => ""
      t.string :coh, :default => ""
      t.string :feeding_claw, :default => ""
      t.string :after_groove, :default => ""
      t.string :before_groove, :default => ""
      t.string :oil_cup, :default => ""
      t.datetime :buy_time
      t.string :release_report
      t.string :fixed_asset_id

      t.boolean :is_idle, :default => false
      t.boolean :is_delete, :default => false
      t.boolean :is_dirty, :default => true
      t.boolean :is_new, :default => true
      t.datetime :idle_time
      t.string :note

      t.timestamps null: false
    end

    add_index :mould_details, :mould_id
    add_index :mould_details, :position
  end
end
