class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def index
		@users = User.all

		respond_to do |format|
			format.html 
			format.json { render json: @users }
		end
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			@user.update_attributes(session_token: generate_token)
			session[:token] = @user.session_token
			render json: @user
		else
			flash[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def show
		@user = User.find(params[:id])

		render json: @user;
	end



end
