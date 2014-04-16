class ListsController < ApplicationController
  def show
    Rails.cache.delete(:moviecredits)
    @list = List.new(params[:id], current_user_movies)
  end

  def index
  end

  private

  def current_user_movies
    user_signed_in? ? MyMovies.new(current_user.movies) : nil
  end
end
