class ApplicationController < ActionController::Base
	before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	require 'the_movie_db'
  
  def after_sign_in_path_for(user)
  profile_path(current_user)
  end

  
  #Shared between actors_controller, lists_controller, and movies_controller
  
  def create
	@movie = Movie.new(movie_params)
	@connector = Connector.new(connector_params)
	@movie.save
			#respond_to do |format|
			#if @movie.save
			#	format.html { redirect_to actor_path(@actor) }
			#	format.json { render json: @movie }
			#	format.js
			#else
			#	format.html { redirect_to _path(@actor) }
			#	format.json { render json: @movie.errors }
			#	format.js
			#end
		#end
	@connector.save	
		respond_to do |format|
				format.html { redirect_to path }
				#format.json { render json: @movie }
				format.js

		end
  end
  
  def destroy 
	@connector = Connector.find_by_user_id_and_movie_id(current_user.id, params[:movie_id])
	#if @connector.present?
	@connector.destroy
	#end
		respond_to do |format|
			format.html { redirect_to path }
			#format.json { render json: @movie }
			format.js 
		end
  end
  
  def update
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