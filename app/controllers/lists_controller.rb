class ListsController < ApplicationController
	helper_method :ive_seen_it
  def show
	@list = Tmdb::TheMovieDb.get_list_by_id(params[:id])
	if user_signed_in?
		@allmovies = current_user.movies.to_a
	end
	
  end
  
  def index
  
  end
  
   def destroy
   path = list_path(params[:id])
		super
  end
  
  
  def create
	path = list_path(params[:id])
	super
  end
  
    def update
	path = list_path(params[:id])
	super
  end
  
  
  	def ive_seen_it(movie_id)

	@allmovies.map(&:serializable_hash).select{|f| f['id'] == movie_id}.any?
	end
	
	 	def get_actors(movie_id)
		ary = Tmdb::TheMovieDb.get_movie_credits_by_movie_id(movie_id)['cast']
		x = {}
		ary.each do |f|
		x[f['name']] = f['id']
		end
		return x
	end
	
	
end
