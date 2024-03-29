# frozen_string_literal: true

# UserMailer
class UserMailer < ApplicationMailer
  default from: ENV['USER_EMAIL_PWRESET']

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email,
         subject: t('defaults.password_reset'))
  end
end
