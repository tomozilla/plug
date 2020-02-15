Rails.application.routes.draw do
  get 'events/index'
  get 'events/create'
  get 'events/show'
  devise_for :users
  root to: 'pages#home'
  namespace :api do
    namespace :v1 do
      get '/login', to: "auth#spotify_request"
      get '/auth', to: "auth#show"
      get '/user', to: "users#create"
    end
  end
  get "library", to: "pages#library"

  resources :events, { only: [:index, :create, :show] }
  resources :tracks, { only: [:create, :delete] }
  resources :artists, { only: [:create, :delete] }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
