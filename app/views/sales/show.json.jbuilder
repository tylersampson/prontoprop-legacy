json.extract! @sale, :id, :code, :property_id, :buyer_id, :purchase_price, :deposit_amount, :deposit_due_on, :attorney_id, :bond_attorney_id, :bond_due_on, :originator_id, :external_id, :commission, :vat, :created_at, :updated_at
json.commissions @sale.commissions do |ap|
  json.agent_id ap.agent_id
  json.agent_name ap.agent.name
  json.commission_percent ap.commission_percent
  json.tax_percent ap.tax_percent
  json.gross_amount ap.gross_amount
  json.total_tax ap.total_tax
  json.nett_amount ap.nett_amount
  
  json.deductions ap.deductions do |d|   
    json.deductable_id d.deductable_id
    json.deductable_name d.deductable.name
    json.amount d.amount
  end
end

