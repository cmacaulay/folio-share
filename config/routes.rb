Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get '/dashboard', to: 'users#show'
end
