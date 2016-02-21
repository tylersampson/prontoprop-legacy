class Commission < ActiveRecord::Base
  belongs_to :commissionable, polymorphic: true, touch: true
  belongs_to :agent
  
  has_many :deductions
  accepts_nested_attributes_for :deductions, allow_destroy: true
  
  def cached_agent
    Agent.cached_find(agent_id)
  end
  
  def cached_deductions
    Rails.cache.fetch([self, 'deductions']) { deductions.to_a }
  end
  
  def total_deductions
    cached_deductions.map(&:amount).inject(0, &:+)
  end
  
  def total_payable
    nett_amount - total_deductions
  end
end
