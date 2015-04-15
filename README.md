#My Movie Tracker
My Movie Tracker is an application created in Ruby on Rails. My Movie Tracker allows you to create a list of movies you have seen. It'll keep track of which actors you've seen the most movies in and how many movies you've seen as part of lists (Top 250, AFI Top 100). You can even compare your list with friends! This is just a sample application I created to learn about working with apis. 

This was the first real application I created. It's not the cleanest but I've kept it on github just as a reminder of my growth as a programmer. Every once in a while I'll come back to it to try cleaning it up a bit.

##Deploying

Clone the repository to your local machine

Setup a config/application.yml file with the following contents, of course replacing 'YOUR API KEY GOES HERE' with your api key. You can get an api key from  http://www.themoviedb.org/documentation/api :


```
defaults: &defaults
  THE_MOVIE_DB_API_KEY: YOUR API KEY GOES HERE 
  ADMIN_USERNAME: YOUR USERNAME GOES HERE 

development:
  <<: *defaults

test:
  <<: *defaults
```

You can also replace YOUR USERNAME GOES HERE with an admin username you'd like to use. The admin is able to update information in the database. For instance, if you notice an actor is missing from a movie, you can update it by going to http://www.themoviedb.org. Then, in order for the added information to update on your webapp, you would click the refresh button.

Now run your standard 

```
rake db:migrate
```

And you should be good to go.
