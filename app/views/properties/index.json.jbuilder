json.array!(@properties) do |property|
  json.extract! property, :id, :code, :name, :owner_id, :listing_type, :external_id  
  json.url property_url(property, format: :json)
end
