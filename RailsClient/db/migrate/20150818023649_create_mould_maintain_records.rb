class CreateMouldMaintainRecords < ActiveRecord::Migration
  def change
    create_table :mould_maintain_records do |t|
      t.string :mould_id, :null => false
      t.integer :count, default: 0
      t.datetime :plan_date
      t.datetime :real_date
      t.string :email, null: false, default: "mj@leoni.com"

      t.timestamps null: false
    end
    add_index :mould_maintain_records, :mould_id
    add_index :mould_maintain_records, :count
  end
end
