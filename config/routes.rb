Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'search', to: 'home#search'
  resources :warehouses, except: %i[destroy] do
    post 'product_entry', on: :member
    post 'product_remove', on: :member
  end
  resources :suppliers, except: %i[destroy]
  resources :product_models, except: %i[index destroy] do
    patch :activate, on: :member
  end
  resources :product_bundles, except: %i[index destroy]
  resources :product_categories, except: %i[destroy]
  get 'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'
  delete 'product_items/entry', to: 'product_items#delete_entry'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :warehouses,         except: %i[new edit destroy]
      resources :suppliers,          except: %i[new edit destroy]
      resources :product_models,     except: %i[new edit destroy]
      resources :product_bundles,    except: %i[new edit destroy]
      resources :product_categories, except: %i[new edit destroy]
    end
  end
end
