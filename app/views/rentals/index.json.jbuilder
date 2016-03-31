json.array!(@rentals) do |rental|
  json.extract! rental, :id, :lease_id, :date_received, :amount_received, :commission, :vat
  json.url rental_url(rental, format: :json)
end
