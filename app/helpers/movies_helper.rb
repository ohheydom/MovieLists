module MoviesHelper
  FormData = Struct.new(:method, :submit, :trclass, :path)

  def ive_seen_it_button(form_data, movie)
    render 'shared_partials/iveseenitbutton', form_data: form_data, movie: movie
  end

  def ive_seen_it_single(movie_id)
    if current_user.movie_ids.include?(movie_id)
      method  = 'delete'
      submit  = true
      trclass = 'movie_watched'
      path    = movie_path(movie_id)
    else
      method  = 'post'
      submit  = false
      trclass = 'movie_unwatched'
      path    = movies_path
    end
    FormData.new(method, submit, trclass, path)
  end
end
