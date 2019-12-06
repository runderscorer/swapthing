class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!
  before_action :check_user_memberships, only: [:new, :create]

  def index
  end

  def new
  end

  def create
    @user = User.invite!({email: user_params[:email].downcase}, current_user) do |u|
      u.skip_invitation = true
    end
    email = NotificationMailer.invitation_instructions(@user).deliver
    if @user.update_attributes(invited_by_id: current_user, invitation_sent_at: Time.now)
      Membership.create(user_id: @user.id, event_id: @event.id)

      redirect_to new_user_invitation_path
      flash[:notice] = 'Your invitation was sent successfully'
    else
      flash[:warn] = 'There was a problem sending your invitation'
      redirect_to new_user_invitation_path
    end
  end

  def update
    super
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end