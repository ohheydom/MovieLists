class MoviesController < ApplicationController
  before_filter :define_paths
  def show
	@movie = Tmdb::TheMovieDb.get_movie_by_id(params[:id])
	unless @movie["status_code"] == 6
		@moviecredits = Tmdb::TheMovieDb.get_movie_credits_by_movie_id(params[:id]) 
    if user_signed_in?
    get_movies_if_user_signed_in
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
    @jpathc = "create"
    @jpathd = "destroy"
    @path = movie_path(params[:id])
  end
end
