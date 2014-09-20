class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_cache_buster
  helper_method :search_url

  # Expire cache
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  # Handle CanCan exceptions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  # Helper method to generate search URL
  def search_url(type, query)
    posts_url + '?type=' + type + '&query=' + query
  end

end
