class SearchesController < ApplicationController
  def show
    @search = Search.new(current_user_movies, { query: params[:query], type: params[:type] })
  end
end
