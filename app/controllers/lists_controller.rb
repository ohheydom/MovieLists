class ListsController < ApplicationController
  def show
    Rails.cache.delete(:moviecredits)
    @list = List.new(params[:id], current_user_movies)
  end

  def index
  end
end
