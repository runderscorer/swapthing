module InvitesHelper
  class MembershipInvite
    def initialize(invite)
      @invite = invite
    end

    def accept_and_create_membership?
      @invite.update_attributes(accepted_at: Time.now)
      user = User.where("id = ? OR email = ?", @invite.recipient_id, @invite.email)

      if user.any?
        membership = Membership.new(user_id: user.last.id, event_id: @invite.event_id)
        membership.save!
        return true
      end

      false
    end
  end
end

