Rails.application.routes.draw do
  resources :match_rooms
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/moves/:pieces_id', to: 'moves#show', as: :move
  # post '/moves/:id/', to: 'moves#update', as: :move

  root 'match_rooms#index'
end
