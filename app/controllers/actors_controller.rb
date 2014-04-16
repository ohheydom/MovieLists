class ActorsController < ApplicationController
  def show
    @actor = Actor.new(params[:id], current_user_movies)
  end

  private

  def current_user_movies
    user_signed_in? ? MyMovies.new(current_user.movies) : nil
  end
end
