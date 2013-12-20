class SearchController < ApplicationController
 
	def index
		@querystring = params[:query]
		@type = params[:type]
    if @type == 'actor'
        @render = 'actor'
    else
        @render = 'movie'
		    @search_movies_list = Tmdb::TheMovieDb.search_by_movie_title(@querystring)
    if user_signed_in?
        get_movies_if_user_signed_in
        @ourmovies =  Tmdb::MovieStats.compare_movies(@allmovies,@search_movies_list['results'])[0]
    end
    end
  end
  
  def create

	super(search_index_path(params[:query]))
  end

  def destroy

	super(search_index_path(params[:query]))
  end

end
