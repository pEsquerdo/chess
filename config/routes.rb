Rails.application.routes.draw do
  resources :match_rooms do
    resource :players
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/moves/:id/', to: 'moves#edit', as: :permitted_moves
  put '/moves/:id/', to: 'moves#update', as: :move_to

  root 'match_rooms#index'
end
