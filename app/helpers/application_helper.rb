module ApplicationHelper
  FormData = Struct.new(:method, :submit, :trclass, :path)

  def full_title(page_title)
    base_title = 'My Movie Tracker'
    page_title.empty? ? base_title : "#{base_title} | #{page_title}".html_safe
  end

  def admin?(movie)
    render('shared_partials/admin', movie: movie) if current_user.username == admin_username
  end

  def ive_seen_it(movie_id, ourmovies)
    if ourmovies.include?(movie_id)
      method  = 'delete'
      submit  = true
      trclass = 'movie-watched'
      path    = movie_path(movie_id)
    else
      method  = 'post'
      submit  = false
      trclass = 'movie-unwatched'
      path    = movies_path
    end
    FormData.new(method, submit, trclass, path)
  end

  def ive_seen_it_button(form_data, movie)
    render 'shared_partials/iveseenitbutton', form_data: form_data, movie: movie
  end

  def user_movies
    current_user ? @_allmovies ||= current_user.movies.to_a : []
  end

  def admin_username
    ENV['ADMIN_USERNAME']
  end
end
