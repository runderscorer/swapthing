class InviteMailer < ActionMailer::Base
  default from: 'swapthing <mail@letsswapthings.com>'

  def new_invitation(invite)
    @token = invite.token
    @invite = invite

    mail to: invite.email,
         subject: "You have been invited to use Swap Thing!"
  end
end
