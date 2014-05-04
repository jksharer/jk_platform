json.array!(@announcements) do |announcement|
  json.extract! announcement, :name, :announcement_type, :content
  json.url announcement_url(announcement, format: :json)
end