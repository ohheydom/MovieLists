module ListsHelper
  def check_movie_counter(list)
    if !user_signed_in?
      link_to('Create a user account', signup_path) + "  to find out how many movies you've seen!"
    else
      "I've seen " + content_tag(:span, list.compare_films_to_user.count, id: 'moviecount') +
      ' out of ' + list.count.to_s + ' movies'
    end
  end
end
