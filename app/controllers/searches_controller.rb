class SearchesController < ApplicationController
  def show
    @search = Search.new(query: params[:query], type: params[:type])
    if @search.partial == 'movie'
      if user_signed_in?
        my_movies = MyMovies.new(user_movies)
        @ourmovies =  my_movies.compare_to(@search.list)
        @listpart = '/shared_partials/list_of_movies'
      else
        @listpart = '/shared_partials/list_of_movies_not_signed_in'
      end
    end
  end
end
