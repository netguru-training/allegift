Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "sessions" }

  resources :gifts do
    patch :register_santa
  end

  root 'welcome#index'
end
