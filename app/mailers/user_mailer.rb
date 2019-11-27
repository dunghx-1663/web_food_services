class UserMailer < ApplicationMailer
  default from: 'dung.ha.xuan97.sun@gmail.com'

  def account_activation user
    binding.pry
    @user = user
    mail(to: @user.email, subject: 'webcome to my website, account activation')
  end

  def order_mail user
    @user = user
    mail to: @user.email, subject: "order detail"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
