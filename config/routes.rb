Rails.application.routes.draw do
  devise_for :users , :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'application#welcome'

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :wines, only: [ :index, :create, :show ]

  resources :reviews, except: [ :new ]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
