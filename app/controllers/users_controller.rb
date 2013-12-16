class UsersController < ApplicationController
	before_filter :authenticate_user!, :get_user_and_render
	helper_method :add_most_recent_movies_and_ids_to_array
	
  def show
  end
  
 
 def index
 end
  
 def create  
   super(profile_path(@user))
 end

 def destroy
   super(profile_path(@user)) 
 end 

  
  def get_user_and_render
    if (current_user.username == params[:id]) || (User.where(username: params[:id]).blank?)
  	  @user = current_user
	    @render = 'users/partials/my_profile'
    else
      @user =  User.find(params[:id])
      @allmovies = current_user.movies.to_a
	    @render = 'users/partials/profile'
    end
    @usermovies = @user.movies.order(title: :asc)
    @usermoviesp = @usermovies.page(params[:page])
  end

  def add_most_recent_movies_and_ids_to_array(user)
    x = []
    idandmovie = []
      user.connectors.order('created_at').last(5).each do |movie|
        x << movie['movie_id']
      end
          Movie.find(x).each_with_index do |mov, arrayloc|
              idandmovie << [mov.title, x[arrayloc]]
        end
      return idandmovie
  end
end
