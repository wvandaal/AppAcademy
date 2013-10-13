class ItemsController < ApplicationController

	def show
		@item = Item.find(params[:id])
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(params[:item])
		if @item.save
			redirect_to @item.project
		else
			flash[:errors] = @item.errors.full_messages
			render :edit
		end
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		if @item.update_attributes(params[:item])
			redirect_to @item.project
		else
			flash[:errors] = @item.errors.full_messages
			render :edit
		end
	end

	def destroy
		item = Item.find(params[:id])
		item.destroy

		redirect_to item.project
	end

end
