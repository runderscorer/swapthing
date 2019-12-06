class CreateAdditionalMembership
  def self.call user_email, event_id
    invite = Invite.find_by(email: user_email.downcase, event_id: event_id)
    user = User.find_by(email: user_email.downcase)
    Membership.create(event_id: invite.event_id, user_id: user.id)
    invite.update(accepted_at: Time.now)
  end
end
