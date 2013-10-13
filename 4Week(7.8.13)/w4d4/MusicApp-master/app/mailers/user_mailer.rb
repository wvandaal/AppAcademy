class UserMailer < ActionMailer::Base
  default from: "accounts@musicapp.com"

  def activation_email(user)
    @user = user
    @url = activate_user_url({:token => @user.activation_token})
    mail(to: @user.email, subject: "Activate your account")
  end
end
