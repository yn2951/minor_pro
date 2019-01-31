class UserResisterationMailer < ApplicationMailer
  default from: 'マイナープロ'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'ご登録ありがとうございます')
  end
end
