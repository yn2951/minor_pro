Rails.application.routes.draw do
  root 'pages#index'

  resources :pages
  resources :users
  resources :topics

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#twitter'
end
