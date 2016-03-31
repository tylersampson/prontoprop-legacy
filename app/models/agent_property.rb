class AgentProperty < ActiveRecord::Base
  has_paper_trail
  belongs_to :agent
  belongs_to :property
end
