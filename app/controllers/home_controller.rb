class HomeController < ApplicationController
  PER_PAGE = 5

  def index
    respond_to do |format|
      format.html do
        @posts = Post.order(created_at: :desc)
          .offset(0)
          .limit(PER_PAGE)
          .includes(:tags)
          .map(&:serializable)
          .to_json
      

        @page = 1 
        @per_page = PER_PAGE
        @number_of_pages = number_of_pages
      end

      format.json do
        posts = Post.order(created_at: :desc)
          .offset((params[:page].to_i - 1) * PER_PAGE)
          .limit(PER_PAGE)
          .includes(:tags)
          .map(&:serializable)

        render json: { items: posts, number_of_pages: number_of_pages }
      end
    end
  end

  private

  def number_of_pages
    (Post.count.to_f / PER_PAGE).ceil
  end
end
