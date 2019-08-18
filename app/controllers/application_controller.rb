class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def ensure_user_is_admin
    redirect_to(root_path) unless current_user&.admin?
  end
end
