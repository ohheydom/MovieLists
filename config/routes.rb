MyMovieTracker::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new', as: 'signup'
  end

  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end

  unauthenticated do
    root to: 'homes#show', via: :get
  end

  resources :users, only: [:show] do
    resource :settings, only: [:show]
  end

  resources :actors, only: [:show]
  resources :movies, only: [:show, :create, :destroy, :update]
  resources :lists, only: [:show, :index]
  resource :search, only: [:show]

  get 'profile/:id', to: 'users#show', as: 'profile'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'
  get '/422', to: 'errors#unprocessable_entity'
end
