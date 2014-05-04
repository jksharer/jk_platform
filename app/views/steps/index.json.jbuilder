json.array!(@steps) do |step|
  json.extract! step, :view_order, :user_id_id
  json.url step_url(step, format: :json)
end