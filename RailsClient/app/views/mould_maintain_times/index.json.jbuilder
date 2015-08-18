json.array!(@mould_maintain_times) do |mould_maintain_time|
  json.extract! mould_maintain_time, :id, :mould_id, :project_id, :device_id, :serviceman, :err_note, :solution_method, :code, :feed_code
  json.url mould_maintain_time_url(mould_maintain_time, format: :json)
end
