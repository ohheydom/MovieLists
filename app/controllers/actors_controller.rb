require 'date'

class ActorsController < ApplicationController
  before_filter :define_paths

  def show
    @actor = Actor.new(params[:id])
    @my_movies = MyMovies.new(user_movies)
    if @actor
      @listpart = user_signed_in? ? 'list_of_movies' : 'list_of_movies_not_signed_in'
    end
  end

  def define_paths
    @jpathc = 'create_and_count'
    @jpathd = 'destroy_and_count'
  end
end
