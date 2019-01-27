class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    new_post = Post.new(post_params)

    if new_post.save
      redirect_to(:posts)
    else
      render(:new)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body_one, :body_two, :gist, :synopsis)
  end
end
