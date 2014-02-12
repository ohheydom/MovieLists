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
resources :actors 
#Movies
resources :movies

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
