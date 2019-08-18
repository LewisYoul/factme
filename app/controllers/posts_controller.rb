class PostsController < ApplicationController
  before_action :ensure_user_is_admin, except: :show

  def new
    @post = Post.new
  end

  def create
    new_post = Post.new(post_params)

    if new_post.save
      redirect_to(:root)
    else
      render(:new)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])

    if post.update(post_params)
      redirect_to(:root)
    else
      render(:edit)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(
      :title, 
      :body_one, 
      :body_two, 
      :gist, 
      :synopsis, 
      { tag_ids: [] }
    )
  end
end
