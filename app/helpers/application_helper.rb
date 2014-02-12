module ApplicationHelper

  def check_movie_counter(movie, list)
    if !user_signed_in?
      link_to("Create a user account", signup_path) + "  to find out how many movies you've seen!"
    else
      "I've seen " + content_tag(:span, Tmdb::MovieStats::compare_list_and_my_movies(movie, list), id: "moviecount") + " out of " + list["items"].count.to_s + " movies"
    end
  end

end
