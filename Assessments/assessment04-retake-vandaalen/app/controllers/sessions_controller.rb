class SessionsController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.find_by_username_and_password(params[:username], params[:password])
		if @user
			@user.session_token = generate_token
			@user.save
			session[:token] = @user.session_token
			redirect_to posts_url
		else
			render :new
		end
	end

	def destroy
		user = User.find_by_session_token(session[:token])
		user.session_token = nil
		user.save
		session[:token] = nil

		redirect_to root_url
	end
end
