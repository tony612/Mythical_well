MythicalWell::Application.routes.draw do
  match 'ui(/:action)', controller: 'ui'
  resources :events, only: [:index, :show]

  root to: "events#index"
end
