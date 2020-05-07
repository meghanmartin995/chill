Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :topics, only: [ :index, :show, ] do
    resources :resources, only: :create
    resources :todos, only: :create
  end
end
