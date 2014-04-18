json.array!(@agencies) do |agency|
  json.extract! agency, :name
  json.url agency_url(agency, format: :json)
end