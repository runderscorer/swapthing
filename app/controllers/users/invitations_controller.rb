class Users::InvitationsController < Devise::InvitationsController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.invite!({email: user_params[:email]}, current_user) do |u|
      u.skip_invitation = true
    end

    email = NotificationMailer.invitation_instructions(@user).deliver

    Role.create(user_id: @user, event_id: params[:event_id])

    redirect_to new_user_invitation_path
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end