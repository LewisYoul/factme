class HomeController < ApplicationController
  PER_PAGE = 5

  def index
    respond_to do |format|
      format.html do
        @all_posts = Post.where(published: true).order(created_at: :desc)

        @posts = @all_posts
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
        @all_posts = Post.where(published: true).order(created_at: :desc)

        if params[:search]
          @all_posts = @all_posts.joins(:tags)
            .where('title ILIKE :search OR tags.name ILIKE :search', search: "%#{params[:search]}%")
        end

        posts = @all_posts
          .offset((params[:page].to_i - 1) * PER_PAGE)
          .limit(PER_PAGE)
          .includes(:tags)
          .map(&:serialize)

          has_next_page = @all_posts.count > (params[:page].to_i) * PER_PAGE

        render json: { items: posts, number_of_pages: number_of_pages, has_next_page: has_next_page }
      end
    end
  end

  private

  def number_of_pages
    (@all_posts.count.to_f / PER_PAGE).ceil > 0 ? (@all_posts.count.to_f / PER_PAGE).ceil : 1
  end
end
