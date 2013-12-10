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

resources :users, :only => [:show, :index]


get "home/index"  
get 'search', to: 'search#index'

#Actors
post '/actor/:id', :controller=>"actors", :action=>"create", to: 'actors#create'
put '/actor/:id', :controller=>"actors", :action=>"update", to: 'actors#update'
delete '/actor/:id', :controller=>"actors", :action=>"destroy", to: 'actors#destroy'
get '/actor/:id', to: 'actors#show', as: 'actor'
  
#Movies
post '/movie/:id', :controller=>"movies", :action=>"create", to: 'movies#create'
delete '/movie/:id', :controller=>"movies", :action=>"destroy", to: 'movies#destroy'
get '/movie/:id', to: 'movies#show', as: 'movie'
  

#Lists
get 'list/:id', to: 'lists#show', as: 'list'
delete '/list/:id', :controller=>"lists", :action=>"destroy", to: 'lists#destroy'
post '/list/:id', :controller=>"lists", :action=>"create", to: 'lists#create'
put '/list/:id', :controller=>"lists", :action=>"update", to: 'lists#update'
get 'lists', to: 'lists#index', as: 'lists'
get "profile/:id", to: 'users#show', as: 'profile'
  
  
    #errors
  
get "/404", to: 'errors#not_found'
get "/500", to: 'errors#internal_server_error'
get "/422", to: 'errors#unprocessable_entity'
  
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end