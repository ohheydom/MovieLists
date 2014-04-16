class Actor
  def initialize(actor_id, current_user)
    @actor = actor_id
    @current_user = current_user
  end

  def films(args = {})
    @_films ||= Tmdb::TheMovieDb.get_movie_credits_by_id(@actor)['cast']
    sort_films(args)
  end

  def films_renderable
    films(sort_by: 'release_date').map { |movie| Tmdb::Movie.new(movie) }
  end

  def compare_films_to_user
    @current_user.compare_to(films)
  end

  def name
    Rails.cache.fetch([:actor_name, @actor]) { Tmdb::TheMovieDb.get_actor_by_id(@actor)['name'] }
  end

  def view_partition
    @current_user.nil? ? 'list_of_movies_not_signed_in' : 'list_of_movies'
  end

  private

  def sort_films(args)
    if args[:sort_by] = 'release_date'
      @_films.sort_by { |mov| mov['release_date'].nil? ? '1900-01-01' : mov['release_date'] }.reverse!
    else
      @_films
    end
  end
end
