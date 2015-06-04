class InvitesController < ApplicationController
  before_filter :get_event

  def new
    @users = @event.users
    @pending_invites = @event.invites.pending
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
    params.require(:invite).permit(:sender_id, :recipient_id, :accepted_at, :event_id, :created_at, :token, :email)
  end
end