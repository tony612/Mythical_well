MythicalWell::Application.routes.draw do
  
  match 'ui(/:action)', controller: 'ui'
  resources :events, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end
  devise_for :users
  resources :users, only: [:show] do
    member do
      get 'set_base'
      put 'update_base', :as => :set_base, :path => 'set_base'
      get 'set_account'
      put 'update_account', :as => :set_account, :path => 'set_account'
    end
  end

  


  root to: "events#index"
end
