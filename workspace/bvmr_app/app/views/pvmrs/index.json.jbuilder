json.array!(@pvmrs) do |pvmr|
  json.extract! pvmr, :id, :total_value, :todays_date
  json.url pvmr_url(pvmr, format: :json)
end
