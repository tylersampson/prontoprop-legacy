class Lease < ActiveRecord::Base
  belongs_to :property
  belongs_to :lessor
  accepts_nested_attributes_for :lessor
  belongs_to :status
  
  has_many :agent_leases
  has_many :agents, through: :agent_leases
end
