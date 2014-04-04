class UsersController < ApplicationController
  before_filter :authenticate_user!, :define_paths
  helper_method :add_most_recent_movies_and_ids_to_array

  def show
    get_user_and_render
  end

  def get_user_and_render
    if (current_user.username == params[:id]) || (User.where(username: params[:id]).blank?)
      @user = current_user
      get_user_movies
      @render = 'users/partials/my_profile'
    else
      @user =  User.find(params[:id])
      get_user_movies
      @render = 'users/partials/profile'
      @ourmovies =  Tmdb::MovieStats.compare_movies(user_movies, @usermovies)[0]
    end

    @usermoviesp = Kaminari.paginate_array(@usermovies).page(params[:page]).per(50)
  end

  def get_user_movies
    @usermoviestotal = @user.movies.order(title: :asc)
    @usermovies = @usermoviestotal.by_year_or_all(params[:by_year]).order(title: :asc)
  end

  def define_paths
    @jpathc = 'create'
    @jpathd = 'destroy'
  end

  def add_most_recent_movies_and_ids_to_array(user)
    idandmovie = []
    x = user.connectors.order('created_at').last(5).map(&:movie_id)
    Movie.find(x).index_by(&:id).slice(*x).each { |movid, movinfo| idandmovie << [movinfo['title'], movid] }
    return idandmovie
  end
end
