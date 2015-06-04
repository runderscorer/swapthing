class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters

  def new
    @user = User.new
    @token = params[:invite_token]
  end

  def create
    super()
binding.pry
    @token = params[:invite_token]
    
    unless @token.blank?
      invite = Invite.find_by token: @token
      invite.accepted_at = Time.now
      invite.save

      membership = Membership.new(user_id: @user.id, event_id: invite.event_id)
      membership.save
    end
  end

  def after_sign_up_path_for(resource)
    events_path
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:fname, :lname)
  end
end