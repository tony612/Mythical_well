MythicalWell::Application.routes.draw do
  
  match 'ui(/:action)', controller: 'ui'
  resources :events, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end
  devise_for :users
  resources :users, only: [:show]

  


  root to: "events#index"
end
