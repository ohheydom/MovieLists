module ApplicationHelper
  def parse_date(date)
    date.nil? || date.empty? ? '1900' : Date.parse(date).strftime('%Y')
  end

  def ive_seen_it(movie_id, ourmovies)
    if ourmovies.include?(movie_id)
      method = 'delete'
      submit = true
      trclass= 'movie_watched'
      path = movie_path(movie_id)
    else
      method = 'post'
      submit = false
      trclass= 'movie_unwatched'
      path   = movies_path
    end
    return method, submit, trclass, path
  end

  def user_movies
    current_user ? @_allmovies ||= current_user.movies.to_a : []
  end
end
