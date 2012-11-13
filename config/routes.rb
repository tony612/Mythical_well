MythicalWell::Application.routes.draw do
  
  #match 'ui(/:action)', controller: 'ui'
  resources :events, only: [:index, :show, :new, :create, :edit, :update] do
    resources :comments, only: [:create, :edit, :update, :delete]
    member do
      post :follow
      post :unfollow
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
  match '/my/events' => "users#my_events", via: :get
  root to: "events#index"
end
