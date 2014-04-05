class ListsController < ApplicationController
  before_filter :define_paths

  def show
    Rails.cache.delete(:moviecredits)
    @list = List.new(params[:id])
    @paginated_list = @list.paginated_list(page: params[:page], per: 50)
    if user_signed_in?
      @my_movies = MyMovies.new(user_movies)
      @listpart = '/shared_partials/list_of_movies'
      @ourmovies =  @my_movies.compare_to(@list.list)
    else
      @listpart = '/shared_partials/list_of_movies_not_signed_in'
    end 
  end

  def index
  end

  def define_paths
    @jpathc = 'create_and_count'
    @jpathd = 'destroy_and_count'
  end
end
