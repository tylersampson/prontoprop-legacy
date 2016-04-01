class Property < ActiveRecord::Base
  has_paper_trail

  belongs_to :owner, class_name: 'Contact'
  accepts_nested_attributes_for :owner

  has_many :agent_properties, dependent: :destroy
  accepts_nested_attributes_for :agent_properties, allow_destroy: true
  has_many :agents, through: :agent_properties

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :leases

  validates :name, presence: true

  def cached_owner
    @cached_owner ||= Contact.cached_find(owner_id)
  end

end
