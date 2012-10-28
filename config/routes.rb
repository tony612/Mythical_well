MythicalWell::Application.routes.draw do
  
  match 'ui(/:action)', controller: 'ui'
  resources :events, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end
  devise_for :users
  resources :users, only: [:show, :index] do
    member do
      get 'set_base'
      put 'update_base', :as => :set_base, :path => 'set_base'
      get 'followers'
      get 'followees'
      post 'follow'
      post 'unfollow'
    end
  end
  match '/my/events' => "users#my_events", via: :get

  root to: "events#index"
end
