class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_action :authenticate_user!

  def new
    @user = User.new
    @token = params[:invite_token]
  end

  def create
    super()

    @token = params[:invite_token]
    
    unless @token.blank?
      invite = Invite.find_by token: @token
      membership = Membership.new(user_id: @user.id, event_id: invite.event_id)
      if membership.save
        wishlist = Wishlist.new(membership_id: membership.id)
        wishlist.save
      end
    end

  end

  def after_sign_up_path_for(resource)
    events_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end