class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.update_attributes(session_token: generate_session_token)
      session[:token] = @user.session_token
      redirect_to posts_path
    else
      flash[:errors] = ["invalid username/password"]
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.attributes= params[:user]
    if @user.save!
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to posts_path
  end

end
