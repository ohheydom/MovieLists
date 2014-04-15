class ProfilePage
  attr_reader :user

  def initialize(user, current_user = nil, options = {})
    @user = user
    @current_user = current_user
    @options = options
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

  def movies_by_year
    movies.by_year_or_all(@options[:by_year])
  end

  def our_movies
    @_compared_films ||= my_movies.map { |movid| movid['id'] } & movies.map { |movid| movid['id'] }
  end

  def paginated_movies(page)
    Kaminari.paginate_array(movies_by_year).page(page).per(50)
  end
end
