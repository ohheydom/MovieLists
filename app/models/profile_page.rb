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

  def our_movie_percentage
    (our_movies.count.to_f / (my_movies.count + movies.count - our_movies.count.to_f)) * 100
  end

  def paginated_movies(page)
    Kaminari.paginate_array(movies_by_year).page(page).per(50)
  end

  def most_recent_movies(number)
    last_movies = @user.recently_added(number).map(&:movie_id)
    Movie.find(last_movies).index_by(&:id).slice(*last_movies).map do |movid, movinfo|
      [movinfo['title'], movid]
    end.reverse
  end

  def top_five_actors
    actors.hash_of_duplicates.sort_by { |k, v| -v } [0..4]
  end

  def top_five_years
    release_date_years.hash_of_duplicates.sort_by { |k, v| -v } [0..4]
  end

  private

  def actors
    movies.each_with_object([]) { |a, obj| a[:actors].each { |act, id| obj << [act, id] } }
  end

  def release_date_years
    movies.map(&:release_date)
  end
end
