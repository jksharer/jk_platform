json.array!(@users) do |user|
  json.extract! user, :username, :password, :password_confirmation, :agency_id
  json.url user_url(user, format: :json)
end