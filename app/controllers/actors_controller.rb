require 'date'

class ActorsController < ApplicationController
helper_method :get_actors, :get_actors_name
  
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
	super(actor_path(@actor))
  end
  
  
  def create
	super(actor_path(@actor))
  end
  
  def update
	super(actor_path(@actor))
  end	
end
