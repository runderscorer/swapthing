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

  def update
    @user = current_user
    @user.update_attributes(user_params)

    if @user.save
      redirect_to events_path
    else 
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:fname, :lname, :email)
  end
end