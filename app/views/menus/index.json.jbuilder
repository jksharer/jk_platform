json.array!(@menus) do |menu|
  json.extract! menu, :name, :url, :status, :display_order
  json.url menu_url(menu, format: :json)
end