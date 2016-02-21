class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!

  def new
    @user = User.new
    @user.build_account
    render layout: 'devise'
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      Apartment::Tenant.create(@user.account.database)
      Apartment::Tenant.switch(@user.account.database) do
        @user.save
        redirect_to new_user_session_path(subdomain: @user.account.database)
      end
    else
      render 'new'
    end
  end

  protected
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :account_attributes => [:name, :database])
  end

end
