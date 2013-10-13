class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = verify_user!(
      params[:user][:username],
      params[:user][:password]
    )
    
    if @user
      login_user!(@user)
      redirect_to posts_url
    else
      render :new
    end
  end
  
  def destroy
    @user = current_user
    if @user.nil?
      redirect_to new_session_url
      return
    else
      logout_user!(@user)
      redirect_to new_session_url
    end
  end
end
