Rails.application.routes.draw do
  resources :users, only: [:new, :create, :edit, :update]

  get '/home', to: 'users#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
