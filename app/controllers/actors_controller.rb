require 'date'

class ActorsController < ApplicationController
helper_method :get_actors, :get_actors_name, :ive_seen_it
  
  def show
	#unless Tmdb::TheMovieDb.get_movie_credits_by_id(params[:id])['cast'].nil?
	@actor = Tmdb::TheMovieDb.get_movie_credits_by_id(params[:id])['cast']
	unless @actor.nil? 
	@actor.sort_by! {|v|  v['release_date'] }.reverse!
	Hash[@actor.map! {|h| h }]
	@actor_name = get_actors_name
	if user_signed_in?
		@allmovies = current_user.movies.to_a
		@watchedmoviescount = 	@allmovies.map {|p| p[:actors].include? @actor_name }.count(true)
		#@watchedmoviescount = current_user.movies.where("actors LIKE '%#{@actor_name.gsub("'","''")}%'").count
	end
	end
  end
  
  def destroy
  @connector = Connector.find_by_user_id_and_movie_id(current_user.id, params[:movie_id])
  if @connector.present?
  @connector.destroy
  end
  
  respond_to do |format|
				format.html { redirect_to actor_path(@actor) }
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
				format.html { redirect_to actor_path(@actor) }
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
				format.html { redirect_to actor_path(params[:id]) }
				format.js
			else
				format.html { redirect_to actor_path(params[:id]) }
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
	  
 	def get_actors(movie_id)
		ary = Tmdb::TheMovieDb.get_movie_credits_by_movie_id(movie_id)['cast']
		x = {}
		ary.each do |f|
		x[f['name']] = f['id']
		end
		return x
	end
	
	def get_actors_name
		Tmdb::TheMovieDb.get_actor_by_id(params[:id])['name']
	end
	
	def ive_seen_it(movie_id)

	@allmovies.map(&:serializable_hash).select{|f| f['id'] == movie_id}.any?
	end
	

	
end
