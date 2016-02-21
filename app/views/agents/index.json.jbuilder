json.array!(@agents) do |agent|
  json.extract! agent, :id, :code, :first_name, :last_name, :name, :id_number, :email, :mobile, :tax
  json.url agent_url(agent, format: :json)
end
