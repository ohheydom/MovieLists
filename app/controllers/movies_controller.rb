class MoviesController < ApplicationController
  before_filter :define_paths

  def show
	  @movie = Tmdb::TheMovieDb.get_movie_by_id(params[:id])
	  unless @movie["status_code"] == 6
      @moviecredits = Rails.cache.fetch([:movie_cache, params[:id]]) { Tmdb::TheMovieDb.get_movie_credits_by_movie_id(params[:id])  }
      if user_signed_in?
        get_movies_if_user_signed_in
      end
    end
  end
   
  def destroy
	  super
  end
  
  
  def create
	  super
  end

  def update
    super
  end

  def define_paths
    @jpathc = "create_and_count"
    @jpathd = "destroy_and_count"
  end
end
