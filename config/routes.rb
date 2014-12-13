Rails.application.routes.draw do
  devise_for :users

  get 'gifts/add'

  get 'gifts/index'

  get 'gifts/create'

  get 'gift/add'

  get 'gift/index'

  get 'gift/create'
end
