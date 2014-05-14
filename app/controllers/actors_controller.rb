class ActorsController < ApplicationController
  def show
    @actor = Actor.new(params[:id], current_user_movies)
  end
end
