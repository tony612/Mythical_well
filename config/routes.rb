MythicalWell::Application.routes.draw do
  devise_for :users

  match 'ui(/:action)', controller: 'ui'
  resources :events, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end
  resources :users, only: [:show]

  root to: "events#index"
end
