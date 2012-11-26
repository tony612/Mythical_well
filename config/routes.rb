MythicalWell::Application.routes.draw do

  #match 'ui(/:action)', controller: 'ui'
  resources :events, only: [:index, :show, :new, :create, :edit, :update] do
    resources :comments, only: [:create, :edit, :update]
    member do
      post :follow
      post :unfollow
    end

    collection do
      get :search
    end
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
      get 'follow_events'
      get 'all_events'
    end
    resources :messages, only: [:index, :destroy] do
      collection do
        post 'empty'
      end
    end
  end
  resources :tags, only: [:index]
  resources :nodes, only: [:index]

  namespace :admin do
    resources :events, only: [:index, :edit, :update, :destroy]
    resources :users, only: [:index, :edit, :update]
    resource :nodes
    resources :comments, only: [:index]
  end

  match '/my/events' => "users#my_events", via: :get
  match '/goto/:node' => "sessions#goto", via: :get, as: :goto
  match '/node/:short_name' => 'events#index', via: :get, as: :node
  root to: "nodes#index"
end
