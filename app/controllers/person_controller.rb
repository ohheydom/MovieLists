require 'date'

class PersonController < ApplicationController
helper_method :get_actors, :get_actors_name, :ive_seen_it
  
  def show
	@person = Tmdb::TheMovieDb.get_movie_credits_by_id(params[:id])['cast'].sort_by {|v|  v['release_date'] }.reverse
	Hash[@person.map! {|h| h }]
	@person_name = get_actors_name
	@allmovies = Connector.all_user_movies(current_user.id).load if user_signed_in?
	
		
  end
  
  def destroy
  @connector = Connector.find_by_user_id_and_movie_id(current_user.id, params[:movie_id])
  if @connector.present?
  @connector.destroy
  end
  
  respond_to do |format|
				format.html { redirect_to person_path(@person) }
				#format.json { render json: @movie }
				format.js 
    end
	
	
  end
  
  
  def create
	@movie = Movie.new(movie_params)
	@connector = Connector.new(connector_params)
	@movie.save
			#respond_to do |format|
			#if @movie.save
			#	format.html { redirect_to person_path(@person) }
			#	format.json { render json: @movie }
			#	format.js
			#else
			#	format.html { redirect_to person_path(@person) }
			#	format.json { render json: @movie.errors }
			#	format.js
			#end
		#end
	@connector.save	
		respond_to do |format|
				format.html { redirect_to person_path(@person) }
				#format.json { render json: @movie }
				format.js

		end
	

	
 end
 
	def movie_params
		params.permit(:id, :title, :actors, :year).merge(:id => params[:movie_id], :actors => get_actors(params[:movie_id]), :year => params[:year])
    end
	
	def connector_params
         params.permit(:user_id, :movie_id).merge(:user_id => current_user.id)
    end
	  
 	def get_actors(movie_id)
		ary = Tmdb::TheMovieDb.get_movie_credits_by_movie_id(movie_id)['cast']
		x = {}
		ary.each do |f|
		x[f['name']] = f['id']
		end
		return x
	end
	
	def get_actors_name
		Tmdb::TheMovieDb.get_actor_by_id(params[:id])['name']
	end
	
	def ive_seen_it(movie_id)

	@allmovies.to_a.map(&:serializable_hash).select{|f| f['movie_id'] == movie_id}.any?
	end
	

	
end
