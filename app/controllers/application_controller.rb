class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :set_mailer_host
  before_filter :check_user_account, if: :current_user

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def check_user_account
    redirect_to root_url(subdomain: current_user.account.database) if request.subdomain != current_user.account.database
  end

  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  around_filter :scope_current_user, if: :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  rescue_from ActiveRecord::InvalidForeignKey do
    redirect_to root_path, :alert => "You can't delete resources that are being used somewhere else"
  end

  protected
  def scope_current_user
    User.current_id = current_user.id
    yield
  ensure
    User.current_id = nil
  end

end
