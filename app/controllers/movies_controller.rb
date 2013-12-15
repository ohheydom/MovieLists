class MoviesController < ApplicationController

  def show
	@movie = Tmdb::TheMovieDb.get_movie_by_id(params[:id])
	unless @movie["status_code"] == 6
		@moviecredits = Tmdb::TheMovieDb.get_movie_credits_by_movie_id(params[:id])
	  get_movies_if_user_signed_in
  end
  end
   
  def destroy
	super(movie_path(params[:id]))
  end
  
  
  def create
	super(movie_path(params[:id]))
  end

end
