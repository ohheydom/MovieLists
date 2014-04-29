module UsersHelper
  def add_most_recent_movies_and_ids_to_array(user, number)
    last_movies = user.connectors.order('created_at').last(number).map(&:movie_id)
    Movie.find(last_movies).index_by(&:id).slice(*last_movies).map { |movid, movinfo| [movinfo['title'], movid] }
  end
end
