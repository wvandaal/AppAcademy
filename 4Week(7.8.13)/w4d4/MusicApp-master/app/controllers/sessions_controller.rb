class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => :destroy

  def new
  end

  def create
    @user = User.find_by_email_and_password(params[:email], params[:password])
    if @user
      if @user.activation_token.nil?
        @user.session_token = generate_session_token
        @user.save!
        session[:token] = @user.session_token
        redirect_to root_url
        return
      else
        flash[:errors] = ["You must activate your account."]
      end
    else
      flash[:errors] = ["invalid email/password"]
    end
    render :new
  end

  def destroy
    @user = User.find_by_session_token(session[:token])
    if @user
      @user.session_token = nil
      session[:token] = nil
      @user.save!
    end
    redirect_to root_url
  end

  private

  def generate_session_token
    token = SecureRandom.urlsafe_base64
    while User.pluck(:activation_token).include?(token)
      token = SecureRandom.urlsafe_base64
    end
    token
  end

end
