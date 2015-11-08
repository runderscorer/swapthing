class InvitesController < ApplicationController
  before_filter :get_event
  before_action :admin_check
  before_action :get_unready_users

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    token = SecureRandom.urlsafe_base64

    @invite.update_attributes! sender_id: current_user.id, event_id: @event.id, token: token

    if @invite.save
      InviteMailer.new_invitation(@invite).deliver
      flash[:notice] = "Sweet! #{@invite.email} has been invited."
      redirect_to new_event_invite_path
    else
      flash.now[:error] = 'Please enter a valid email address.'
      render :new
    end
  end

  def destroy
    invite = Invite.find(params[:id])
    invite.destroy
    redirect_to new_event_invite_path
  end

  def reminder
    user_email = User.find(params[:user_id]).email

    if NotificationMailer.reminder_mail(params[:user_id], params[:event_id]).deliver
      flash[:notice] = "Awesome! An reminder has been sent to #{user_email}."
    else
      flash[:error] = "Uh oh. Something went wrong. Try again."
    end

    redirect_to new_event_invite_path @event
  end

  private

  def get_unready_users
    @unready_users = @event.users.includes(:wishlist).where(wishlists: {id: nil})
  end

  def invite_params
    params.require(:invite).permit(:sender_id, :recipient_id, :accepted_at, :event_id, :created_at, :token, :email)
  end
end