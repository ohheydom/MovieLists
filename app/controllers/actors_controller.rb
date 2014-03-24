require 'date'

class ActorsController < ApplicationController
  before_filter :define_paths

  def show
    @actor = Tmdb::TheMovieDb.get_movie_credits_by_id(params[:id])['cast']
    if @actor
      @actor.sort_by! {|v| v['release_date'].nil? ? '1900-01-01' : v['release_date'] }.reverse!
      @actor_name =  get_actors_name(params[:id])
      if user_signed_in?
        get_movies_if_user_signed_in
        @ourmovies =  Tmdb::MovieStats.compare_movies(@allmovies,@actor)[0]
        @watchedmoviescount = @ourmovies.count
        @listpart = "list_of_movies"
      else
        @listpart = "list_of_movies_not_signed_in"
	    end
    end
  end

  def define_paths
    @jpathc = "create_and_count"
    @jpathd = "destroy_and_count"
  end
end
