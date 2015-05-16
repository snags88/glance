Rails.application.routes.draw do
  root 'albums#index'
  resources :albums

  get '/welcome' => 'sessions#new', as: 'welcome'
  get '/auth/instagram', as: 'oauth'
  get '/auth/instagram/callback' =>'sessions#create'
  get '/signout' => 'sessions#destroy', as: 'signout'

end
