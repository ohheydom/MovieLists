class Search
  SEARCH_TYPES = %w(movie actor)
  def initialize(args = {})
    @query = args[:query]
    @type = args[:type]
  end

  def partial
    SEARCH_TYPES.include?(@type) ? @type : 'movie'
  end

  def list
    response['results']
  end

  def list_count
    response['total_results']
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
