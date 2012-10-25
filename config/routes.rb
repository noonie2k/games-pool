GamesPool::Application.routes.draw do
  resources :games do
    collection do
      get  'find'
      post 'find'
    end

    member do
      get 'hold'
    end
  end

  resources :pools do
    collection do
      get  'join'
      post 'join' => :create_membership
    end
  end

  resources :users do
    member do
      get 'account'
    end
  end

  controller :loans do
    post 'loan/issue/:id'    => :issue,    as: 'issue_loan'
    post 'loan/complete/:id' => :complete, as: 'complete_loan'
    post 'loan/cancel/:id  ' => :cancel,   as: 'cancel_loan'
  end

  controller :sessions do
    get  'login'
    post 'login'  => :create_session
    get  'logout'
  end

  # Administration Namespace
  namespace :admin do
    resources :platforms
  end

  root to: 'home#index'
end
