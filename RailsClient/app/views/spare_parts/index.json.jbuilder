json.array!(@spare_parts) do |spare_part|
  json.extract! spare_part, :id, :record_date, :mould_id, :project_id, :spare_type, :spare_kind, :broken_state, :maintainman, :qty, :machine_id, :outbound_id
  json.url spare_part_url(spare_part, format: :json)
end
