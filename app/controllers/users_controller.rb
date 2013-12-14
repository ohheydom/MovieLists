class UsersController < ApplicationController
	before_filter :authenticate_user!, :get_user_and_render
	
	helper_method :add_most_recent_movies_and_ids_to_array
	
  def show


  end
  
 
  def index
	#@user = current_user
  end
  
  

  
  def get_user_and_render
    if (current_user.username == params[:id]) || (User.where(username: params[:id]).blank?)
  	@user = current_user
	@usermovies = @user.movies.to_a
	@render = 'users/partials/my_profile'
    else
    @user =  User.find(params[:id])
	@usermovies = @user.movies.to_a
	@render = 'users/partials/profile'
	end
   end

  def add_most_recent_movies_and_ids_to_array(usermovies)
    x = []
      usermovies.last(5).each do |movie|
        x << [movie['title'], movie['id']]
      end
      return x
  end
end
