class UsersController < ApplicationController
	
  def new
  	@teams = Team.order("name")
  	@user = User.new
	end

	def create
		@teams = Team.order("name")
		@user = User.new(params[:user])
		if @user.save
			@user.team_ids = params[:team_ids]
			redirect_to @user
		else
			flash[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
	end

end
