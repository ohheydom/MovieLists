module UsersHelper
  def add_most_recent_movies_and_ids_to_array(user, number)
    x = user.connectors.order('created_at').last(number).map(&:movie_id)
    Movie.find(x).index_by(&:id).slice(*x).map { |movid, movinfo| [movinfo['title'], movid] }
  end
end
