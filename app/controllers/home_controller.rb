class HomeController < ApplicationController

  DEFAULT_PAGE = 1
  PER_PAGE = 5

  def index
    @posts = Post.order(created_at: :desc)
      .offset(amount_to_offset)
      .limit(PER_PAGE)
      .includes(:tags)
    
      @previous_page = page - 1
      @current_page = page
      @next_page = page + 1

      @is_first_page = page == 1

      number_of_posts = Post.count 
      @is_last_page = number_of_posts <= (page * PER_PAGE)
  end

  private

  def amount_to_offset
    (page - 1) * PER_PAGE
  end

  def page
    @page ||= params[:page]&.to_i || DEFAULT_PAGE 
  end
end
