require 'date'

class PersonController < ApplicationController
  def show
  @person = Tmdb::TheMovieDb.get_movie_credits_by_id(params[:id])['cast'].sort_by {|v| v['release_date'] }
  Hash[@person.map! {|h| h }]
  end
end
