Rails.application.routes.draw do
  root 'albums#index'
  resources :albums

  get '/signin' => 'sessions#new', as: 'signin'
  get '/auth/instagram', as: 'oauth'
  get '/auth/instagram/callback' =>'sessions#create'
  get '/signout' => 'sessions#destroy', as: 'signout'

end
