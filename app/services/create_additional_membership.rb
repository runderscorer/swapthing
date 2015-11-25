class CreateAdditionalMembership
  def self.call user_email
    invite = Invite.where(email: user_email).last
    user = User.find_by email: user_email
    membership = Membership.create(event_id: invite.event_id, user_id: user.id)
  end
end