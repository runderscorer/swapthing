class NotificationMailer < ActionMailer::Base
  default from: 'help@swap-thing.com'

  def invitation_instructions(user)
    @user = user
    invitation_link = accept_user_invitation_url(invitation_token: @token)

    mail to: @user.email,
         subject: "You have been invited to use Swap-Thing!"
  end

  def partner_assignment_mail(partnership)
    email = partnership.giver.email
    @giver = partnership.giver
    @getter = partnership.getter

    mail to: email,
         subject: "You've been assigned a party for your gift exchange - Time to party!"
  end

  def reminder_mail(user_id, event_id)
    email = User.find(user_id).email
    @event = Event.find(event_id)

    mail to: email,
         subject: "A friendly reminder to add items to your wishlist."
  end
end