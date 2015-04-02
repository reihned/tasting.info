Rails.application.routes.draw do
  devise_for :users

  root 'application#welcome'

  resources :wines, only: [ :index, :create, :show ]

  resources :reviews, except: [ :new ]

  resources :identities, only: [ :new, :create, :show ]

  get '/auth/:provider/callback', to: 'identities#create'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
