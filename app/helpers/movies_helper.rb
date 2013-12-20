module MoviesHelper

    def ive_seen_it_single(movie_id)
        if @allmovies.map {|mov| mov['id']}.include?(movie_id)
            method = "delete"
            submit = "Oops, haven't seen it!"
            action = "destroy"
            trclass="movie_watched" 
        else
				    method = "post"
            submit = "I've seen it!"
            action = "create"
            trclass="movie_unwatched"
        end 
        return method, submit, action, trclass
    end

end
