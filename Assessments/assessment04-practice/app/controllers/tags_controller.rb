class TagsController < ApplicationController

  def create
    tag = Tag.new(params[:tag])
    tag.save
    redirect_to :back
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to :back
  end
end
