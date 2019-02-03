class UserResisterationMailer < ApplicationMailer
  default from: 'minor-pro@gmail.com'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'ご登録ありがとうございます')
  end
end
