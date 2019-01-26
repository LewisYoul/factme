class HomeController < ApplicationController

  def index
    @recent_posts = Post.order(created_at: :desc).first(5)
  end

end
