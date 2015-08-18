json.array!(@knife_switch_slices) do |knife_switch_slice|
  json.extract! knife_switch_slice, :id, :mould_id, :project_id, :terminal_leoni_id, :knife_type1, :knife_type2, :wire_type, :image_after, :image_before
  json.url knife_switch_slice_url(knife_switch_slice, format: :json)
end
