class UserMailer < ActionMailer::Base
  default from: "everybody@appacademy.io"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to 99Cats!")
  end
end
