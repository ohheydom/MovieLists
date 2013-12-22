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
	super(@path)
  end

  def destroy
	super(@path)
  end

   def define_paths
      @path = movie_path(params[:id])
      @jpathc = 'create'
      @jpathd = 'destroy'
   end
end
