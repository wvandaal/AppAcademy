class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_username(params[:user][:username])
    if user && user.password == params[:user][:password]
      token = SecureRandom.base64(16)
      user.session_token = token
      user.save
      session[:session_token] = token
      redirect_to posts_path
    else
      redirect_to :back
    end
  end

  def destroy
    user = User.find_by_session_token(session[:session_token])
    user.session_token = SecureRandom.base64(8)
    session[:session_token] = nil
    redirect_to new_session_path
  end
end
