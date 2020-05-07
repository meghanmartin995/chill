Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :topics, only: [ :index, :show, :create ] do
    resources :resources, only: :create
    resources :todos, only: [ :create, :destroy ]
  end
  resources :resources, only: :destroy

  resources :todos, only: [ :destroy, :update ]
end
