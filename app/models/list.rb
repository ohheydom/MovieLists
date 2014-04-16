class List
  def initialize(id, current_user_movies)
    @list ||= Tmdb::TheMovieDb.get_list_by_id(id)
    @current_user_movies = current_user_movies
  end

  def name
    @list['name']
  end

  def status_code
    @list['status_code']
  end

  def list
    @list['items']
  end

  def count
    list.count
  end

  def compare_films_to_user
    @current_user_movies.compare_to(list)
  end

  def view_partial
    @current_user_movies.nil? ? 'list_of_movies_not_signed_in' : 'list_of_movies'
  end

  def list_renderable(page)
    paginated_list(page).map { |movie| Tmdb::Movie.new(movie) }
  end

  def paginated_list(page)
    Kaminari.paginate_array(list).page(page).per(50)
  end
end
