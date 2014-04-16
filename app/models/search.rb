class Search
  SEARCH_TYPES = %w(movie actor)

  def initialize(current_user_movies, args = {})
    @current_user_movies = current_user_movies
    @query = args[:query]
    @type = args[:type]
  end

  def partial
    SEARCH_TYPES.include?(@type) ? @type : 'movie'
  end

  def view_partial
    @current_user_movies.nil? ? 'list_of_movies_not_signed_in' : 'list_of_movies'
  end

  def list
    response['results']
  end

  def list_renderable
    list.map { |movie| Tmdb::Movie.new(movie) }
  end

  def list_count
    response['total_results']
  end

  def compare_list_to_user
    @current_user_movies.compare_to(list)
  end

  private

  def response
    @_response ||= @type == 'movie' ? search_by_movie_title(@query) : search_by_actor(@query)
  end

  def search_by_movie_title(title)
    Tmdb::TheMovieDb.search_by_movie_title(title)
  end

  def search_by_actor(actor)
    Tmdb::TheMovieDb.search_by_actor(actor)
  end
end
