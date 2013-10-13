class ProjectsController < ApplicationController

	def show
		@project = Project.includes(:items).find(params[:id])
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(params[:project])
		if @project.save
			redirect_to @project
		else
			flash[:errors] = @project.errors.full_messages
			render :new
		end
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		if @project.update_attributes(params[:project])
			redirect_to @project
		else
			flash[:errors] = @project.errors.full_messages
			render :edit
		end
	end

	def destroy
		project = Project.find(params[:id])
		project.destroy

		redirect_to projects_path
	end

end
