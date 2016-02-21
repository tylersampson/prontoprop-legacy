class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  around_filter :scope_current_user, if: :current_user  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, :alert => exception.message
  end
  
  rescue_from ActiveRecord::InvalidForeignKey do
    redirect_to :back, :alert => "You can't delete resources that are being used somewhere else"
  end
  
  protected
  def scope_current_user        
    User.current_id = current_user.id
    yield
  ensure
    User.current_id = nil
  end
  
end
