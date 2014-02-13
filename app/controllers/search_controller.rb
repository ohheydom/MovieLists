class SearchController < ApplicationController
  before_filter :define_paths 
  before_action :delete_cache, only: :index

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
        @listpart = '/shared_partials/list_of_movies'
      else
        @listpart = '/shared_partials/list_of_movies_not_signed_in'
      end
    end
  end

  def define_paths
    @jpathc = 'create'
    @jpathd = 'destroy'
   end

end
