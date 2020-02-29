Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get "/export", to: "pages#export_spotify"
  post "/star_track", to: "events#star_track"
  delete "/star_track", to: "events#unstar_track"

  post "/star_artist", to: "events#star_artist"
  delete "/star_artist", to: "events#unstar_artist"

  namespace :api do
    namespace :v1 do
      get '/login', to: "auth#spotify_request"
      get '/auth', to: "auth#show"
      get '/user', to: "users#create"
    end
  end

  get "library", to: "pages#library"

  resources :events, { only: [:index, :create, :show] } do
    member do
      post 'check_in'
    end
  end
  resources :tracks, { only: [:create, :delete] }
  resources :artists, { only: [:create, :delete] }

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
