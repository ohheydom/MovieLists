require 'faraday'
require 'json'

module Tmdb
  class TheMovieDb
    # Constants
    API_KEY = ENV["THE_MOVIE_DB_API_KEY"]
    BASE_URI = 'http://api.themoviedb.org/3'
    PICTURE_URL = 'http://d3gtl9l2a4fn1j.cloudfront.net/t/p/w92'

    @conn = Faraday.new(url: BASE_URI) do |faraday|
      faraday.request  :url_encoded
      faraday.params = { api_key: API_KEY }
      faraday.response :logger
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter  Faraday.default_adapter
    end

    def self.get_movie_by_id(movie_id)
      x = @conn.get 'movie/' + movie_id
      JSON.parse(x.body)
    end

    def self.get_list_by_id(list_id)
      x = @conn.get 'list/' + list_id
      JSON.parse(x.body)
    end

    def self.get_movie_credits_by_movie_id(movie_id)
      x = @conn.get "movie/#{movie_id}/credits"
      JSON.parse(x.body)
    end

    def self.get_movie_credits_by_id(actor_id)
      x = @conn.get "person/#{actor_id}/movie_credits"
      JSON.parse(x.body)
    end

    def self.search_by_movie_title(movie_title)
      begin
        x = @conn.get 'search/movie', { query: CGI::escape(movie_title) }
        JSON.parse(x.body)
      rescue
      end
    end

    def self.search_by_actor(actor)
      begin
        x = @conn.get 'search/person', { query: CGI::escape(actor) }
        JSON.parse(x.body)
      rescue
      end
    end

    def self.get_actor_by_id(actor_id)
      x = @conn.get "person/#{actor_id}"
      JSON.parse(x.body)
    end
  end

  class MovieStats
    def self.number_of_movies(user)
      @number = user.count
    end

    def self.add_actors_to_hash(user)  #Top 5
      actor_array = []
      user.each { |a| a[:actors].each { |act, id| actor_array << [act, id] } }
      return Hash[Array.duplicate_hashes(actor_array).sort_by { |k, v| -v } [0..4]]
    end

    def self.compare_movies(my_profile, other_profile)
      myary = my_profile.map { |movid| movid['id'] }
      otherary = other_profile.map { |movid| movid['id'] }
      mov_together = (myary & otherary)
      return mov_together, ((mov_together.count.to_f / (otherary.count + myary.count - mov_together.count.to_f)) * 100)
    end

    def self.add_years_to_hash(user) #Top 5
      Hash[Array.duplicate_hashes(user.map(&:year)).sort_by { |k, v| -v } [0..4]]
    end

    def self.compare_list_and_my_movies(my_movies, list)
      my_movie_ids =  my_movies.map { |movie| movie['id'] }
      list_movie_ids = list['items'].map { |movie| movie['id'] }
      (my_movie_ids & list_movie_ids).count
    end
  end
end
