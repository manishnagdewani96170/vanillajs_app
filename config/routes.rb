Rails.application.routes.draw do
  root to: 'home#index'
  get '/game' => 'home#game'
  resources :attachments, only: [:create, :index]
end
