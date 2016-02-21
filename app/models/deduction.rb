class Deduction < ActiveRecord::Base
  belongs_to :commission, touch: true
  belongs_to :deductable
  
  validates :deductable_id, presence: true
  
  def cached_deductable
    Deductable.cached_find(deductable_id)
  end
end
