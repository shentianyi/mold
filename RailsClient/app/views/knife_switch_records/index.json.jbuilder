json.array!(@knife_switch_records) do |knife_switch_record|
  json.extract! knife_switch_record, :id, :mould_id, :project_id, :knife_type, :knife_kind, :knife_supplier, :state, :problem, :damage_define, :maintainman, :m_qty, :machine_id, :press_num, :damage_life, :broken_life, :total_life
  json.url knife_switch_record_url(knife_switch_record, format: :json)
end
