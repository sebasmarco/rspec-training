class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = 'Post created.'
      redirect_to @post
    else
      flash[:alert] = 'Error!'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted.'
    else
      flash[:alert] = 'Error!'
    end

    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
