class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(username: params[:username], password: params[:password])
		if @user.save
			@user.session_token = generate_token
			@user.save
			session[:token] = @user.session_token
			redirect_to posts_url
		else
			render :new
		end
	end
end
