json.array!(@deductables) do |deductable|
  json.extract! deductable, :id, :code, :name, :unit_price
  json.url deductable_url(deductable, format: :json)
end
