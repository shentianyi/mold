json.array!(@mould_details) do |mould_detail|
  json.extract! mould_detail, :id, :mould_id, :mould_type, :mould_supplier, :position, :terminal_leoni_no, :terminal_supplier, :stopwater, :use_range, :wire_type, :wire_cross
  json.url mould_detail_url(mould_detail, format: :json)
end
