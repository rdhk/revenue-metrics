json.array!(@ivmrs) do |ivmr|
  json.extract! ivmr, :id, :ivmr_value, :api_time
  json.url ivmr_url(ivmr, format: :json)
end
