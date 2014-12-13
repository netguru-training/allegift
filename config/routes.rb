Rails.application.routes.draw do
  devise_for :users

  resources :gifts

  root 'welcome#index'
end
