require 'date'

class ActorsController < ApplicationController
  before_filter :define_paths  

  def show
    @actorarr = Tmdb::TheMovieDb.get_movie_credits_by_id(params[:id])
    @actor = @actorarr['cast']
    unless @actor.nil? 
	    @actor.sort_by! {|v| v['release_date'].nil? ? '1900-01-01' : v['release_date'] }.reverse!
	    @actor_name = get_actors_name
	    if user_signed_in?
        get_movies_if_user_signed_in
        @ourmovies =  Tmdb::MovieStats.compare_movies(@allmovies,@actorarr['cast'])[0]
        @watchedmoviescount = @ourmovies.count
        @listpart = "list_of_movies"
      else
        @listpart = "list_of_movies_not_signed_in"
	    end
    end
  end
  
  def destroy
    super(@path)
  end
  
  
  def create
    super(@path)
  end
  
  def update
    super(@path)
  end	

  def define_paths 
    @path = movies_path
    @jpathc = "create_and_count"
    @jpathd = "destroy_and_count"
  end

end
