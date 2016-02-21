class Sale < ActiveRecord::Base
  belongs_to :property
  belongs_to :buyer, class_name: 'Contact'
  belongs_to :attorney
  belongs_to :bond_attorney, class_name: 'Attorney'
  belongs_to :originator
  belongs_to :status
  belongs_to :bank
  
  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments
    
  has_many :commissions, as: :commissionable
  has_many :deductions, through: :commissions
  accepts_nested_attributes_for :commissions
  
  after_commit :flush_cache
  
  validates :code, :property_id, :purchase_price, :contract_start_on, :status_id, presence: true
  validates :commission, presence: true, numericality: { greater_than: 0 }
  validate :contract_and_reg_dates
  
  def contract_and_reg_dates
    errors.add(:registered_on, "cannot be older than contract start date") if registered_on.present? && registered_on < contract_start_on
    errors.add(:contract_start_on, "cannot be after registration date") if registered_on.present? && registered_on < contract_start_on
  end
  
  def description
    "SALE - #{property.name}"
  end
  
  def cached_comments
    Rails.cache.fetch([self, 'comments']) { comments.to_a }
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def cached_commissions
    Rails.cache.fetch([self, 'commissions']) { commissions.to_a }
  end
    
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def self.in_range(from, to)
    from ||= Date.today.beginning_of_month
    to ||= Date.today.end_of_month
    where('contract_start_on >= ? AND contract_start_on <= ?', from, to)
  end
    
  def self.preferred_origination
    joins(:originator).where('originators.preferred = TRUE')
  end
  
  def self.preferred_attorneys
    joins(:attorney).where('attorneys.preferred = TRUE')
  end
  
  def self.granted
    joins(:status).where('statuses.category = \'Closed\'')
  end
  
  def self.pending
    joins(:status).where('statuses.category = \'Active\'')
  end
  
  def self.declined
    joins(:status).where('statuses.category = \'Cancelled\'')
  end
      
end
