Rails.application.routes.draw do
  devise_for :users

  resources :gifts, only: [:add, :create, :index, :delete]
end
