require 'date'

class ActorsController < ApplicationController
helper_method :get_actors, :get_actors_name
  
  def show
    @actorarr = Tmdb::TheMovieDb.get_movie_credits_by_id(params[:id])
    @actor = @actorarr['cast']
    unless @actor.nil? 
	    @actor.sort_by! {|v|  v['release_date'] }.reverse!
	    @actor_name = get_actors_name
	    if user_signed_in?
        get_movies_if_user_signed_in
        @ourmovies =  Tmdb::MovieStats.compare_movies(@allmovies,@actorarr['cast'])[0]
        @watchedmoviescount = @ourmovies.count
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
