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
         subject: 'You have been assigned a partner! Time to dance!'
  end
end