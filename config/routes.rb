Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :topics, only: [ :index, :show, :create, :new ] do
    resources :resources, only: [ :create, :index ]
    resources :columns, except: [:index, :show] do
      resources :todos, except: [:index, :show]
    end
  end
  resources :resources, only: :destroy

  resources :todos, only: [ :destroy, :update ]
end
