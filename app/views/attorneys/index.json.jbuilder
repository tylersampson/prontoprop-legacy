json.array!(@attorneys) do |attorney|
  json.extract! attorney, :id, :code, :name, :email, :telephone
  json.url attorney_url(attorney, format: :json)
end
