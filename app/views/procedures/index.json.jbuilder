json.array!(@procedures) do |procedure|
  json.extract! procedure, :name
  json.url procedure_url(procedure, format: :json)
end