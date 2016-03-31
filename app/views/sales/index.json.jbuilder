json.array!(@sales) do |sale|
  json.extract! sale, :id, :code, :property_id, :buyer_id, :purchase_price, :deposit_amount, :deposit_due_on, :attorney_id, :bond_attorney_id, :bond_due_on, :originator_id, :external_id, :commission, :vat
  json.url sale_url(sale, format: :json)
end
