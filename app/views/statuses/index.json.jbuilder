json.array!(@statuses) do |status|
  json.extract! status, :id, :name, :access
  json.url status_url(status, format: :json)
end
