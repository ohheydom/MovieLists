class ApplicationController < ActionController::Base
	require 'the_movie_db'
	helper_method :get_admin_username
	before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location
#  after_action :delete_cache, only: [:create, :destroy]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
  
  def after_sign_up_path_for(resource)
    profile_path(resource)
  end

  def after_sign_in_path_for(resource)
    profile_path(resource)
  end

  def store_location
    if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/password" &&
      !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end
  
  def delete_cache
    Rails.cache.clear
  end
  
  def update (path)
	  @oldmovie = Movie.find(params[:movie_id])
	  if @oldmovie.present?
		  @oldmovie.update(movie_params)
		  respond_to do |format|
			  if @oldmovie.update(movie_params)
				  format.html { redirect_to path }
				  format.js
			  else
				  format.html { redirect_to path }
				  format.js
			  end
		  end
	  end
  end
  
  def get_movies_if_user_signed_in
		@allmovies = current_user.movies.to_a 
  end  

  def get_actors(movie_id) #Get all the actors for a movie by id
		ary = Rails.cache.fetch([:movie_cache, movie_id]) { Tmdb::TheMovieDb.get_movie_credits_by_movie_id(movie_id) }
		x = {}
		ary['cast'].each do |f|
		  x[f['name']] = f['id']
		end
		return x
	end
	
	def get_actors_name(actor_id) #Get actors name by id
    Rails.cache.fetch([:actor_name, actor_id]) { Tmdb::TheMovieDb.get_actor_by_id(actor_id)['name'] }
	end

  def get_admin_username
    ENV["ADMIN_USERNAME"]
  end

	# STRONG PARAMS
  def movie_params
		params.permit(:id, :title, :actors, :year).merge(:id => params[:movie_id], :actors => get_actors(params[:movie_id]), :year => params[:year])
  end
	
	def connector_params
    params.permit(:user_id, :movie_id).merge(:user_id => current_user.id)
  end	

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
	  devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
  end
  
end
