class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location
  protect_from_forgery with: :exception

  def after_sign_up_path_for(resource)
    profile_path(resource)
  end

  def after_sign_in_path_for(resource)
    profile_path(resource)
  end

  def store_location
    if (request.fullpath != '/users/sign_in' &&
      request.fullpath != '/users/sign_up' &&
      request.fullpath != '/users/password' &&
      !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def delete_cache
    Rails.cache.clear
  end

  private

  def current_user_movies
    user_signed_in? ? MyMovies.new(current_user.movies) : nil
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
  end
end
