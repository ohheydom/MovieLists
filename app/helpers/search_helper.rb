module SearchHelper

	def list_movies(movie)
		Tmdb::TheMovieDb.search_by_movie_title(movie)
  end
  
  def list_people(actor)
    Tmdb::TheMovieDb.search_by_actor(actor)
	end
  
end
