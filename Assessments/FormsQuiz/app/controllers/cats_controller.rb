class CatsController < ApplicationController
  
  def show
    @cat = Cat.includes(:color, :humans).find(params[:id])
  end
  
  def new
  end
  
  def create
    # Will fail hard if not valid, intended
    @cat = Cat.create!(params[:cat])
    redirect_to @cat
  end
  
end