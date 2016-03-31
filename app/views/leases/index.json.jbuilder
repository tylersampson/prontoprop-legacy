json.array!(@leases) do |lease|
  json.extract! lease, :id, :code, :property_id, :lessor_id, :managed, :start_on, :end_on, :actual_end_on, :rent_amount, :deposit_amount, :deposit_held_by, :lease_fee, :inspection_fee, :credit_check_fee, :credit_check_fee_paid_on, :deposit_released_on, :deposit_released_to, :status_id
  json.url lease_url(lease, format: :json)
end
