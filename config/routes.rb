Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get '/home', to: 'users#show'
end
