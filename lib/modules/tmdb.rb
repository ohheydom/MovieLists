require 'faraday'
require 'json'

module Tmdb
  PICTURE_URL = 'http://image.tmdb.org/t/p/w92'

  class Movie
    attr_reader :id

    def initialize(movie)
      @movie ||= movie
      @id = @movie['id']
    end

    def character
      @movie['character']
    end

    def credits
      unless status_code == 6
        Rails.cache.fetch([:movie_cache, @id]) do
          Tmdb::TheMovieDb.get_movie_credits_by_movie_id(@id)
        end
      end
    end

    def overview
      @movie['overview']
    end

    def poster_path
      @movie['poster_path'] ? PICTURE_URL + @movie['poster_path'] : NullObjects::NoPosterPath.new.poster_path
    end

    def release_date
      release_date = @movie['release_date'].blank? ? NullObjects::NoReleaseDate.new.release_date : @movie['release_date']
      Date.parse(release_date).strftime('%Y')
    rescue
      release_date
    end

    def status_code
      @movie['status_code']
    end

    def tagline
      @movie['tagline']
    end

    def title
      @movie['title']
    end

    def title_and_release_date
      "#{title} (#{release_date})"
    end
  end

  class TheMovieDb
    API_KEY = ENV["THE_MOVIE_DB_API_KEY"]
    BASE_URI = 'http://api.themoviedb.org/3'

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
end
