Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "sessions" }

  resources :gifts

  root 'welcome#index'
end
