Rails.application.routes.draw do
  devise_for :users

  resources :gifts do
    patch :register_santa
  end

  root 'welcome#index'
end
