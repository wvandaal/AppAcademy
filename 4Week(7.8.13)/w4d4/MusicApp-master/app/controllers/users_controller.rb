class UsersController < ApplicationController
  before_filter :authenticate_user, :only => :destroy

  def new
    @user = User.new
  end

  def activate
    @user = User.find_by_activation_token(params[:token])
    if @user
      @user.activation_token= nil
      @user.save!
    else
      flash[:errors] = ["Invalid activation token."]
    end
    redirect_to new_session_url
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      msg = UserMailer.activation_email(@user)
      msg.deliver!
      redirect_to root_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_url
  end
end
