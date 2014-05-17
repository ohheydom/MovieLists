class MoviesController < ApplicationController
  def show
    @movie = Tmdb::Movie.new(Tmdb::TheMovieDb.get_movie_by_id(params[:id]))
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    @connector = current_user.connectors.new(connector_params)
    @connector.save
    respond_to do |format|
      format.html { redirect_to movie_path(@movie.id) }
      format.js { render 'shared_javascripts/create' }
    end
  end

  def destroy
    current_user.movies.delete params[:movie_id]
    respond_to do |format|
      format.html { redirect_to movie_path(params[:movie_id]) }
      format.js  { render 'shared_javascripts/destroy' }
    end
  end

  def update
    @oldmovie = Movie.find_by(id: params[:movie_id])
    if @oldmovie
      @oldmovie.update(movie_params)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render nothing: true }
      end
    else
      render nothing: true
    end
  end

  private

  def connector_params
    params.permit(:user_id, :movie_id)
  end

  def movie_params
    params.permit(:id, :title, :actors, :release_date)
    .merge(id: params[:movie_id], actors: get_actors(params[:movie_id]))
  end

  def get_actors(movie_id) # Get all the actors for a movie by id
    ary = Rails.cache.fetch([:movie_cache, movie_id]) { Tmdb::TheMovieDb.get_movie_credits_by_movie_id(movie_id) }
    ary['cast'].each_with_object({}) { |actor, obj| obj[actor['name']] = actor['id'] }
  end
end
