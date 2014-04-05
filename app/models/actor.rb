class Actor
  def initialize(actor_id)
    @actor = actor_id
  end

  def films(args = {})
    @_films ||= Tmdb::TheMovieDb.get_movie_credits_by_id(@actor)['cast']
    sort_films(args)
  end

  def name
    Rails.cache.fetch([:actor_name, @actor]) { Tmdb::TheMovieDb.get_actor_by_id(@actor)['name'] }
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
