Rails.application.routes.draw do
  resources :shipments do
    member  do
      get 'add_inventory'
      post 'assign_inventory'
      post 'remove_inventory'
    end
  end
  resources :cities
  resources :states
  resources :countries
  resources :inventories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "main#index"
end
