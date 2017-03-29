Rails.application.routes.draw do
  get '/home', to: 'users#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :users, only: [:new, :create]
  resources :folders, path: :f, only: :show
  resources :uploads, path: :u, only: :show
end
