class Agent < ActiveRecord::Base
  has_paper_trail
  has_many :commissions

  validates :code, :first_name, :last_name, :tax, presence: true
  validates :tax, numericality: { greater_than: 0, less_than: 100 }

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def name
    "#{first_name} #{last_name}"
  end
end
