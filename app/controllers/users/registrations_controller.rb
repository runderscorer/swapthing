class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters

  def new
    @user = User.new
    @token = params[:invite_token]

    if @token
      exisiting_user = User.find_by email: Invite.find_by(token: @token).email

      if exisiting_user
        redirect_to new_user_session_path popular: true
      end
    else
      super()
    end
  end

  def create
    super()
    @token = params[:invite_token]

    unless @token.blank?
      invite = Invite.find_by token: @token
      invite.accepted_at = Time.now
      invite.save

      membership = Membership.new(user_id: @user.id, event_id: invite.event_id)
      membership.save
    end
  end

  def edit
  end

  def update
    @user = current_user

    if user_params[:password].present?
      @user.update_attributes(user_params)
    else
      @user.update_without_password(user_params)
    end

    if @user.save
      sign_in current_user, bypass: true
      flash[:notice] = 'Cool! Your profile has been updated.'
      redirect_to events_path
    else
      flash.now[:error] = 'Your profile was not updated. Please review the errors below.'
      render :edit
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname])
  end
end
