Rails.application.routes.draw do
  root 'topics#index'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',
    unlocks:       'users/unlocks'
  }

  resources :users
  resources :topics

  get '/resisteration/:id', to: 'sessions#resisteration_done'

  get 'profiles/edit'
  patch 'profiles/update'

  get '/detail', to: 'topics#detail'
  delete '/topics', to: 'topics#destroy'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # get '/auth/:provider/callback', to: 'sessions#twitter'

  post '/comments', to: 'comments#create'

  post   '/follows', to: 'follows#create'
  delete '/follows', to: 'follows#destroy'

  post   '/goods', to: 'goods#create'
  delete '/goods', to: 'goods#destroy'

  post   '/minors', to: 'minors#create'
  delete '/minors', to: 'minors#destroy'

  post   '/bookmarks', to: 'bookmarks#create'
  delete '/bookmarks', to: 'bookmarks#destroy'

  get '/overview', to: 'topics#overview'

  get '/search', to: 'topics#search'
end
