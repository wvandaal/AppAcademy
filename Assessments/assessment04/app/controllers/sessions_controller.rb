class SessionsController < ApplicationController
  
	def new
		
	end

	def create
		@user = User.find_by_username_and_password(params[:user][:username], params[:user][:password])
		if @user
			@user.session_token = generate_session_token
			@user.save!
			session[:token] = @user.session_token
			redirect_to posts_path
		else
			flash[:errors] = ["invalid username/password"]
			render :new
		end
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

end
