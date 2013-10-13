class PostsController < ApplicationController

  def index
    if current_user
      @posts = Post.where(:user_id => current_user.id)
    else
      redirect_to new_session_path
    end
  end

  def new
    if current_user
      @post = Post.new
      render :new
    else
      redirect_to new_session_path
    end
  end

  def create
    p current_user
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    post = Post.find(params[:id])
    post.update_attributes(params[:post])
    redirect_to post_path(post)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy

  end

end
