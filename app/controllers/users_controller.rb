class UsersController < ApplicationController
  before_filter :get_event, only: [:index]
  before_filter :admin_check, only: [:index]

  def index
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