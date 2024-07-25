class UserMailer < ApplicationMailer
  def send_invitation_email(user)
    @user = user
    @token = InvitationWebToken.encode(user_id: @user.id)
    mail(to: @user.email, subject: 'You have an invitation by Usman')
  end
end