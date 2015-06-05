class UsersController < ApplicationController
  before_action :get_event, only:[:index]

  def index
    @users = @event.users
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)

    if @user.save!
      redirect_to events_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:fname, :lname, :email)
  end
end