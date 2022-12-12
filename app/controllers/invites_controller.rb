class InvitesController < ApplicationController
  include InvitesHelper
  before_action :get_event, except: [:reminder, :pending, :update]
  before_action :admin_check, except: [:reminder, :pending, :update]
  before_action only: [:create] do
    validate_emails params[:emails]
  end

  def new
    @invite = Invite.new
  end

  def create
    params[:emails].each do |email|
      invite = Invite.new(email: email)
      token = SecureRandom.urlsafe_base64
      existing_user_id = User.where(email: email.downcase).present? ? User.find_by(email: email.downcase).id : nil

      invite.update(sender_id: current_user.id, recipient_id: existing_user_id, event_id: @event.id, token: token)

      if invite.save
        InviteMailer.new_invitation(invite).deliver
        flash[:notice] = "Sweet! Your invitations have been sent."
      else
        flash[:error] = "Uh oh. Something went wrong. Try again."
      end
    end
    redirect_to new_event_invite_path
  end

  def pending
    @pending_invites = Invite.where("recipient_id = ? OR email = ?", current_user.id.to_s, current_user.email).pending
  end

  def update
    invite = Invite.find params[:id]
    membership_invite_helper = InvitesHelper::MembershipInvite.new(invite)

    if Invite.by_user_id_or_email(current_user).any? && membership_invite_helper.accept_and_create_membership?
      flash[:notice] = "Great! You've accepted your invitation!"
    else
      flash[:error] = "Yikes. Something went wrong. Try again."
    end

    redirect_to pending_invites_user_path(current_user.id)
  end

  def destroy
    invite = Invite.find(params[:id])
    invite.destroy
    redirect_back fallback_location: :index, event_id: @event.id
  end

  def reminder
    invite = Invite.find params[:id]

    if InviteMailer.new_invitation(invite).deliver
      flash[:notice] = "A reminder was sent to #{invite.email}."
    else
      flash[:error] = "Uh oh. Something went wrong. Try again."
    end

    redirect_back fallback_location: :index, event_id: invite.event_id
  end

  private

  def invite_params
    params.require(:invite).permit(:sender_id, :recipient_id, :accepted_at, :event_id, :created_at, :token, :email)
  end

  def validate_emails emails
    emails.each do |email|
      if !valid_email_format email
        flash[:error] = 'Please enter a valid email address.'
        redirect_to new_event_invite_path and return
      end
    end
  end

end
