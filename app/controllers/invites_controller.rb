class InvitesController < ApplicationController

  def new
    @users = Event.find(params[:event_id]).users
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id
    @invite.event_id = session[:event_id]
    if @invite.save
      InviteMailer.new_invitation(@invite).deliver
    end
    redirect_to new_event_invite_path
  end

  private

  def invite_params
    params.require(:invite).permit(:email)
  end
end