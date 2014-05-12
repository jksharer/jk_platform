json.array!(@projects) do |project|
  json.extract! project, :name, :user_id, :description, :department_id, :priority, :start_date, :end_date, :status
  json.url project_url(project, format: :json)
end