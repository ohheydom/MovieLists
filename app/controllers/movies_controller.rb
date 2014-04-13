class MoviesController < ApplicationController
  def show
    @movie = Tmdb::Movie.new(Tmdb::TheMovieDb.get_movie_by_id(params[:id]))
    unless @movie.status_code == 6
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
      format.js { render action: '../shared_javascripts/create' }
    end
  end

  def destroy
    current_user.movies.delete params[:movie_id]
    respond_to do |format|
      format.html { redirect_to movie_path(params[:movie_id]) }
      format.js  { render action: '../shared_javascripts/destroy' }
    end
  end

  def update
    @oldmovie = Movie.find(params[:movie_id])
    if @oldmovie.present?
      @oldmovie.update(movie_params)
      respond_to do |format|
        if @oldmovie.update(movie_params)
          format.html { redirect_to root_path }
          format.js { render nothing: true }
        else
          format.html { redirect_to root_path }
          format.js { render nothing: true }
        end
      end
    end
  end

  private

  def connector_params
    params.permit(:user_id, :movie_id).merge(:user_id => current_user.id)
  end

  def movie_params
    params.permit(:id, :title, :actors, :year).merge(:id => params[:movie_id], :actors => get_actors(params[:movie_id]), :year => params[:year])
  end
end
