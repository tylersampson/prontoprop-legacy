class AgentProperty < ActiveRecord::Base
  belongs_to :agent
  belongs_to :property
end
