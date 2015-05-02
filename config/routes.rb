Rails.application.routes.draw do
  get '/auth/instagram', as: 'signin'
  get '/auth/instagram/callback' =>'sessions#create'
  get '/signout' => 'sessions#destroy', as: 'signout'

  root 'sessions#new'
end
