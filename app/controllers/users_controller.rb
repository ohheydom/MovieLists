class UsersController < ApplicationController
	before_filter :authenticate_user!, :get_user_and_render
	
	helper_method :number_of_movies, :add_actors_to_hash, :add_unique_actor_and_id_to_array
	
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
   
   def add_unique_actor_and_id_to_array(user)
   x = []
   	user.each do |movie|
		movie.actors.each do |actor, id|
			x << [actor, id]
		end
	end
	return x
   end
	
end