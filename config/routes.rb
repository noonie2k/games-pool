GamesPool::Application.routes.draw do
  resources :pools do
    member do
      get 'join'
      post 'join' => :create_membership
    end
  end

  resources :users

  controller :sessions do
    get 'login'
    post 'login' => :create_session
    get 'logout'
  end

  # Administration Namespace
  namespace :admin do
    resources :platforms
  end

  root to: 'home#index'
end
