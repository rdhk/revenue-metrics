json.array!(@samples) do |sample|
  json.extract! sample, :id, :order_date, :sales
  json.url sample_url(sample, format: :json)
end
