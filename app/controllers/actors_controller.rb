require 'date'

class ActorsController < ApplicationController
  def show
    @actor = Actor.new(params[:id])
    @my_movies = MyMovies.new(user_movies)
    if @actor
      @listpart = user_signed_in? ? 'list_of_movies' : 'list_of_movies_not_signed_in'
    end
  end
end
