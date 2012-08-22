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

  root to: 'home#index'
end
