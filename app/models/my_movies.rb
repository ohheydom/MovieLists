class MyMovies
  attr_reader :movies

  def initialize(movies)
    @movies = movies
  end

  def count
    @movies.count
  end

  def compare_to(list)
    @_compared_films ||= @movies.map { |movid| movid['id'] } & list.map { |movid| movid['id'] }
  end
end
