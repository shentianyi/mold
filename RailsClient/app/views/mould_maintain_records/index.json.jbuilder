json.array!(@mould_maintain_records) do |mould_maintain_record|
  json.extract! mould_maintain_record, :id, :mould_id, :count, :plan_date, :real_date
  json.url mould_maintain_record_url(mould_maintain_record, format: :json)
end
