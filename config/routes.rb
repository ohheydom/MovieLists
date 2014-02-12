MovieLists::Application.routes.draw do

  
devise_for :users

devise_scope :user do
	get "sign_in", :to => "users/sessions#new"
	get "sign_up", :to => "users/registrations#new", as: "signup"
end
	
authenticated :user do
	root to: "users#show", as: :authenticated_root
end

unauthenticated do
	root to: "home#index"
end

resources :search
get "home/index"  

#Actors
post '/actor/:id', :controller=>"actors", :action=>"create", to: 'actors#create'
put '/actor/:id', :controller=>"actors", :action=>"update", to: 'actors#update'
delete '/actor/:id', :controller=>"actors", :action=>"destroy", to: 'actors#destroy'
get '/actor/:id', to: 'actors#show', as: 'actor'
  
#Movies
post '/movie/:id', :controller=>"movies", :action=>"create", to: 'movies#create'
delete '/movie/:id', :controller=>"movies", :action=>"destroy", to: 'movies#destroy'
get '/movie/:id', to: 'movies#show', as: 'movie'
put '/movie/:id', :controller=>"movies", :action=>"update", to: 'movies#update'

#Lists
get 'list/:id', to: 'lists#show', as: 'list'
delete '/list/:id', :controller=>"lists", :action=>"destroy", to: 'lists#destroy'
post '/list/:id', :controller=>"lists", :action=>"create", to: 'lists#create'
put '/list/:id', :controller=>"lists", :action=>"update", to: 'lists#update'
get 'lists', to: 'lists#index', as: 'lists'

#Users
delete 'profile/:id', :controller=>"users", :action=>"destroy", to: 'users#destroy'
post '/profile/:id', :controller=>"users", :action=>"create", to: 'users#create'
get "profile/:id", to: 'users#show', as: 'profile'
    
#errors
get "/404", to: 'errors#not_found'
get "/500", to: 'errors#internal_server_error'
get "/422", to: 'errors#unprocessable_entity'
  
end
