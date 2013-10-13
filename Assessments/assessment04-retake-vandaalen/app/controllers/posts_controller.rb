class PostsController < ApplicationController

	before_filter :logged_in_user, only: [:new, :create, :index]
	before_filter :is_author, only: [:edit, :update, :destroy]


	def index
		@posts = current_user.try(:posts)
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			redirect_to @post
		else
			flash[:errors] = @post.errors.full_messages
			render :new
		end
	end

	def show
		@post = Post.find(params[:id])
		@tag = Tag.new
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
			redirect_to @post
		else
			render :edit
		end
	end

private
	def logged_in_user
		unless logged_in?
			redirect_to root_url
		end
	end

	def is_author
		unless Post.find(params[:id]).user == current_user
			redirect_to root_url
		end
	end
end
