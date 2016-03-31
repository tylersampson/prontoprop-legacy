json.array!(@originators) do |originator|
  json.extract! originator, :id, :code, :name, :email, :telephone
  json.url originator_url(originator, format: :json)
end
