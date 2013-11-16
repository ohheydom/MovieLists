module SearchHelper

	def list_movies(movie)
		Tmdb::TheMovieDb.search_by_movie_title(movie)
    end
  
    def list_people(person)

		Tmdb::TheMovieDb.search_by_person(person)
	end
  
  
end
