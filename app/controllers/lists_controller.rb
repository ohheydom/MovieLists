class ListsController < ApplicationController
require 'will_paginate/array'
	

  def show
	@list = Tmdb::TheMovieDb.get_list_by_id(params[:id])
	@listp = @list['items'].paginate(page: params[:page], per_page: 50)
  if user_signed_in?
    @allmovies = current_user.movies.to_a 
		@watchedmoviescount = 0
	end
	
  end
  
  def index
  
  end
  
  def destroy
	super(list_path(params[:id]))
  end
  
  
  def create
	super(list_path(params[:id]))
  end
  
    def update
	super(list_path(params[:id]))
  end
  
end
