class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    get_user_and_render
  end

  def get_user_and_render
    my_movies = MyMovies.new(user_movies)
    if (current_user.username == params[:id]) || (User.where(username: params[:id]).blank?)
      @user = current_user
      get_user_movies
    else
      @user =  User.find(params[:id])
      get_user_movies
      @ourmovies =  my_movies.compare_to(@usermovies)
    end

    @usermoviesp = Kaminari.paginate_array(@usermovies).page(params[:page]).per(50)
  end

  def get_user_movies
    @usermoviestotal = @user.movies.order(title: :asc)
    @usermovies = @usermoviestotal.by_year_or_all(params[:by_year]).order(title: :asc)
  end
end
