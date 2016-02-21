class Contact < ActiveRecord::Base
  belongs_to :contactable, polymorphic: true
  
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
