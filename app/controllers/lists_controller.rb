class ListsController < ApplicationController
	

  def show
	@list = Tmdb::TheMovieDb.get_list_by_id(params[:id])
	@listp = Kaminari.paginate_array(@list['items']).page(params[:page]).per(50)
  if user_signed_in?
    @listpart = 'list_of_movies'
    get_movies_if_user_signed_in
      @ourmovies =  Tmdb::MovieStats.compare_movies(@allmovies,@list['items'])[0]
  else
    @listpart = 'list_of_movies_not_signed_in'
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
