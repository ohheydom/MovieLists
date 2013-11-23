class MovieController < ApplicationController
  def show
  @movie = Tmdb::TheMovieDb.get_movie_by_id(params[:id])
  @moviecredits = Tmdb::TheMovieDb.get_movie_credits_by_movie_id(params[:id])
  
  end
  
end