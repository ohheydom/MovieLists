class ListsController < ApplicationController
	

  def show
	@list = Tmdb::TheMovieDb.get_list_by_id(params[:id])
	@listp = Kaminari.paginate_array(@list['items']).page(params[:page]).per(50)
  get_movies_if_user_signed_in
	
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
