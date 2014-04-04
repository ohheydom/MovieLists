module MoviesHelper

  def ive_seen_it_single(movie_id)
    if user_movies.map {|mov| mov['id']}.include?(movie_id)
      method  = "delete"
      submit  = true
      trclass = "movie_watched"
      path    = movie_path(movie_id)
    else
		  method  = "post"
      submit  = false
      trclass = "movie_unwatched"
      path    = movies_path
    end
    return method, submit, trclass, path
  end
end
