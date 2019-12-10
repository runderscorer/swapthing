module InvitesHelper
  class UserInvite
    def initialize(user)
      @user = user
    end

    def pending
      Invite
        .where("recipient_id = ? OR email = ?", @user.id.to_s, @user.email)
        .where(accepted_at: nil)
    end
  end
end