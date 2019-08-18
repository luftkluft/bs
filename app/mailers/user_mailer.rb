class UserMailer < ApplicationMailer
  default from: 'notifications@bs.com'

  def welcome_email(user)
    @user = user
    @url  = 'https://bs-t.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to BookStore')
  end

  def order_email(user)
    @user = user
    mail(to: @user.email, subject: 'Order from BookStore')
  end
end
