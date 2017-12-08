class UsersController < ApplicationController
  before_action :get_event, only: [:index]
  before_action :admin_check, only: [:index]

  def index
    @pending_user_invites = @event.invites.where(accepted_at: nil)
    @users = @event.users.joins(:wishlist)
    @user = User.find(current_user).decorate
  end

  def edit
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation)
  end
end
