Rails.application.routes.draw do
  devise_for :users
  root to: 'topics#index'

  resources :topics, only: [ :index, :show, :create, :new, :destroy ] do
    resources :resources, only: [ :create, :index ]
    resources :columns, except: [:index, :show, :new] do
      resources :todos, except: [:index, :show, :new]
    end
  end
  resources :resources, only: :destroy

  resources :todos, only: [ :destroy, :update ]
end
