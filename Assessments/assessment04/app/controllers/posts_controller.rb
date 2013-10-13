class PostsController < ApplicationController

	before_filter :user_logged_in, only: [:new, :create, :destroy, :index]

	def index
		@posts = current_user.posts
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def create
		@user = current_user
		@post = @user.posts.build(params[:post])
		if @post.save
			redirect_to @post
		else
			render :new
		end
	end

	private

	def user_logged_in
		unless logged_in?
			redirect_to new_session_path
		end
	end

end
