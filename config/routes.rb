Rails.application.routes.draw do
  devise_for :users

  resources :gifts

  get 'auth/:provider/callback' => 'sessions#create', as: 'signin'
  post 'signout' => 'sessions#destroy', as: 'signout'

  root 'welcome#index'
end
