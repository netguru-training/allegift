Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "sessions" }

  resources :gifts do
    patch :register_santa
    collection do
      get :santa_list
      get :wish_list
      get :live_search
    end
  end

  root 'welcome#index'
end
