GamesPool::Application.routes.draw do
  resources :users

  controller :sessions do
    get 'login'
    post 'login' => :create_session
    get 'logout'
  end

  root to: 'home#index'
end
