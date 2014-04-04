class ApplicationController < ActionController::Base
  require 'the_movie_db'
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

  def get_actors(movie_id) # Get all the actors for a movie by id
    ary = Rails.cache.fetch([:movie_cache, movie_id]) { Tmdb::TheMovieDb.get_movie_credits_by_movie_id(movie_id) }
    ary['cast'].each_with_object({}) { |f, obj| obj[f['name']] = f['id'] }
	end

  def get_actors_name(actor_id) # Get actors name by id
    Rails.cache.fetch([:actor_name, actor_id]) { Tmdb::TheMovieDb.get_actor_by_id(actor_id)['name'] }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
  end
end
