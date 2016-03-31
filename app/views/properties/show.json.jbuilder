json.extract! @property, :id, :code, :name, :owner_id, :listing_type, :external_id, :created_at, :updated_at
json.agents @property.agent_properties do |ap|
  json.id ap.agent_id
  json.name ap.agent.name
  json.tax_percent ap.agent.tax
  json.commission_percent ap.commission_percent
end
