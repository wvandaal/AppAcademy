class TeamsController < ApplicationController

	def show
		@team = Team.includes(:users).find(params[:id])
	end

	def new
		@team = Team.new
	end

	def create
		@team = Team.new(params[:team])
		if @team.save
			redirect_to @team
		else
			flash[:errors] = @team.errors.full_messages
			render :new
		end
	end

	def edit
		@team = Team.find(params[:id])
	end

	def update
		@team = Team.find(params[:id])
		if @team.update_attributes(params[:team])
			redirect_to @team
		else
			flash[:errors] = @team.errors.full_messages
			render :edit
		end
	end

	def destroy
		team = Teams.find(params[:id])
		team.destroy
	end

	def edit_members
		@users = User.order("name")
		@team = Team.includes(:users).find(params[:id])
	end

	def update_members
		team = Team.find(params[:id])
		team.user_ids = params[:user_ids]
		redirect_to team
	end

end
