Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses,    only: [:show, :new, :create]
  resources :suppliers,     only: [:index, :show, :new, :create]
  resources :product_models, only: [:show, :new, :create]
end
