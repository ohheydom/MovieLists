class ApplicationController < ActionController::Base
	require 'the_movie_db'
	helper_method :ive_seen_it, :get_admin_username
	before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location
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
  
  #Shared between actors_controller, lists_controller, and movies_controller
  
  def create (path)
	  @movie = Movie.new(movie_params)
	  @movie.save
	  @connector = Connector.new(connector_params)
	  @connector.save	
	  respond_to do |format|
	    format.html { redirect_to path }
		  format.js { render action: "../shared_javascripts/" + @jpathc } 
	  end 
  end
  
  def destroy (path)
	  @connector = Connector.find_by_user_id_and_movie_id(current_user.id, params[:movie_id])
	  @connector.destroy
	  respond_to do |format|
		  format.html { redirect_to path }
		  format.js  { render action: "../shared_javascripts/" + @jpathd }
	  end
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
  
  def ive_seen_it(movie_id, ourmovies) #Return true or false if you've seen the movie
    if ourmovies.include?(movie_id)
		  method = "delete"
      submit = "Oops, haven't seen it!"
      trclass="movie_watched" 
      path = movie_path(movie_id)
    else
		  method = "post"
      submit = "I've seen it!"
      trclass="movie_unwatched"
      path   = movies_path
    end 
    return method, submit, trclass, path
  end

  def get_movies_if_user_signed_in
		@allmovies = current_user.movies.to_a 
  end  

  def get_actors(movie_id) #Get all the actors for a movie by id
		ary = Tmdb::TheMovieDb.get_movie_credits_by_movie_id(movie_id)['cast']
		x = {}
		ary.each do |f|
		  x[f['name']] = f['id']
		end
		return x
	end
	
	def get_actors_name #Get actors name by id
		Tmdb::TheMovieDb.get_actor_by_id(params[:id])['name']
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
