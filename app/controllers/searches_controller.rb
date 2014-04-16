class SearchesController < ApplicationController
  def show
    @search = Search.new(current_user_movies, { query: params[:query], type: params[:type] })
  end

  private

  def current_user_movies
    user_signed_in? ? MyMovies.new(current_user.movies) : nil
  end
end
