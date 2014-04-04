class MoviesController < ApplicationController
  before_filter :define_paths

  def show
    @movie = Tmdb::TheMovieDb.get_movie_by_id(params[:id])
    unless @movie['status_code'] == 6
      @moviecredits = Rails.cache.fetch([:movie_cache, params[:id]]) { Tmdb::TheMovieDb.get_movie_credits_by_movie_id(params[:id])  }
    end
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    @connector = Connector.new(connector_params)
    @connector.save
    respond_to do |format|
      format.html { redirect_to movie_path(@movie.id) }
      format.js { render action: '../shared_javascripts/' + @jpathc }
    end
  end

  def destroy
    current_user.movies.delete params[:movie_id]
    respond_to do |format|
      format.html { redirect_to movie_path(params[:movie_id]) }
      format.js  { render action: '../shared_javascripts/' + @jpathd }
    end
  end

  def update
    super
  end

  def define_paths
    @jpathc = 'create_and_count'
    @jpathd = 'destroy_and_count'
  end

  private

  def connector_params
    params.permit(:user_id, :movie_id).merge(:user_id => current_user.id)
  end

  def movie_params
    params.permit(:id, :title, :actors, :year).merge(:id => params[:movie_id], :actors => get_actors(params[:movie_id]), :year => params[:year])
  end
end
