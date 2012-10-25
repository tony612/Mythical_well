MythicalWell::Application.routes.draw do
  match 'ui(/:action)', controller: 'ui'
  resources :events, only: [:index, :show, :new, :create]
  resources :users, only: [:show]

  root to: "events#index"
end
