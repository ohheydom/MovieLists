class ListsController < ApplicationController
	helper_method :ive_seen_it
  def show
	@list = Tmdb::TheMovieDb.get_list_by_id(params[:id])
	if user_signed_in?
		@allmovies = current_user.movies.to_a
	end
	
  end
  
  def index
  
  end
   def destroy
	@connector = Connector.find_by_user_id_and_movie_id(current_user.id, params[:movie_id])
	#if @connector.present?
	@connector.destroy
	#end
		respond_to do |format|
			format.html { redirect_to list_path(params[:id]) }
			#format.json { render json: @movie }
			format.js 
		end
  end
  
  
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
				format.html { redirect_to list_path(params[:id]) }
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
				format.html { redirect_to list_path(params[:id]) }
				format.js
			else
				format.html { redirect_to list_path(params[:id]) }
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
  
  	def ive_seen_it(movie_id)

	@allmovies.map(&:serializable_hash).select{|f| f['id'] == movie_id}.any?
	end
	
	 	def get_actors(movie_id)
		ary = Tmdb::TheMovieDb.get_movie_credits_by_movie_id(movie_id)['cast']
		x = {}
		ary.each do |f|
		x[f['name']] = f['id']
		end
		return x
	end
	
	
end
