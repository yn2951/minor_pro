Rails.application.routes.draw do
  root 'topics#index'

  resources :users
  resources :topics

  get '/detail', to: 'topics#detail'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#twitter'

  post '/comments', to: 'comments#create'

  post   '/goods', to: 'goods#create'
  delete '/goods', to: 'goods#destroy'

  post   '/minors', to: 'minors#create'
  delete '/minors', to: 'minors#destroy'

  post   '/bookmarks', to: 'bookmarks#create'
  delete '/bookmarks', to: 'bookmarks#destroy'
end
