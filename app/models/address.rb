class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  validates :suburb, :city, presence: true
  
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
