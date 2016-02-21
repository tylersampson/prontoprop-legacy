class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user  
  
  default_scope -> { where(user_id: User.current_id).order(:event_on => :asc) }
end
