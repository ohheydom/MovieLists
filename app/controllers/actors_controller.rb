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
	path = actor_path(@actor)
	super
  end
  
  
  def create
	path = actor_path(@actor)
	super
  end
  
  def update
	path = actor_path(params[:id])
	super
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
