module ApplicationHelper

  def check_movie_counter(movie, list)
    if !user_signed_in?
      link_to("Create a user account", signup_path) + "  to find out how many movies you've seen!"
    else
      "I've seen " + content_tag(:span, Tmdb::MovieStats::compare_list_and_my_movies(movie, list), id: "moviecount") + " out of " + list["items"].count.to_s + " movies"
    end
  end

  def parse_date(date)
    date.nil? || date.empty? ? '1900' : Date.parse(date).strftime('%Y')
  end

  def ive_seen_it(movie_id, ourmovies) #Return true or false if you've seen the movie
    if ourmovies.include?(movie_id)
		  method = "delete"
      submit = true
      trclass="movie_watched"
      path = movie_path(movie_id)
    else
		  method = "post"
      submit = false
      trclass="movie_unwatched"
      path   = movies_path
    end
    return method, submit, trclass, path
  end
end
