class UserMailer < ApplicationMailer
  default from: 'notifications@bs.com'

  def welcome_email(user)
    @user = user # params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Site')
  end
end
