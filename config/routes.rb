Depot::Application.routes.draw do
  get "store/index"

  resources :products

  root :to => 'store#index', as: 'store'

  # match ':controller(/:action(/:id))(.:format)'
end
