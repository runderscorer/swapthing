class NotificationMailer < ActionMailer::Base
  default from: 'help@swap-thing.com'

  def invitation_instructions(user)
    @user = user
    invitation_link = accept_user_invitation_url(invitation_token: @token)

    mail to: @user.email,
         subject: "You have been invited to use Swap-Thing!"
  end

end