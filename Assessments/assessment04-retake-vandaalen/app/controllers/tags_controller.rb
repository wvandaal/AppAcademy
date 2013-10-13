class TagsController < ApplicationController

	def create
		@tag = Tag.new(params[:tag])
		if @tag.save
			redirect_to @tag.post
		else
			render @tag.post
		end
	end

	def destroy
		tag = Tag.find(params[:id])
		post = tag.post
		tag.destroy

		redirect_to post
	end
end
