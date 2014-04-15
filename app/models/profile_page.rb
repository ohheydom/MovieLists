class ProfilePage
  attr_reader :user

  def initialize(user, current_user = nil)
    @user = user
    @current_user = current_user
  end

  def username
    @user.username
  end

  def my_movies
    @current_user.movies.order(title: :asc)
  end

  def movies
    @_movies ||= @user.movies.order(title: :asc)
  end

  def our_movies
    @_compared_films ||= my_movies.map { |movid| movid['id'] } & movies.map { |movid| movid['id'] }
  end

  def paginated_movies(page)
    Kaminari.paginate_array(movies).page(page).per(50)
  end
end
