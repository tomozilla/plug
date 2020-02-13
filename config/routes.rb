Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dashboard", to: "dashboard#show"
  resources :events, { only: [:index, :create, :show] }
  resources :tracks, { only: [:create, :delete] }
  resources :artists, { only: [:create, :delete] }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
