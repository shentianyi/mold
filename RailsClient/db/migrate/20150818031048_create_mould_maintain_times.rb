class CreateMouldMaintainTimes < ActiveRecord::Migration
  def change
    create_table :mould_maintain_times do |t|
      t.string :mould_id, :null => false
      t.string :project_id, :default => ""
      t.string :device_id, :default => ""
      t.string :serviceman, :default => ""
      t.datetime :maintain_date
      t.string :err_note, :default => ""
      t.string :solution_method, :default => ""
      t.string :code, :default => ""
      t.string :feed_code, :default => ""
      t.string :start_time
      t.string :end_time
      t.integer :downtime

      t.timestamps null: false
    end
    add_index :mould_maintain_times, :mould_id
  end
end
