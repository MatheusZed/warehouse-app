Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses,         except: %i[destroy] do
    post 'product_entry', on: :member
  end
  resources :suppliers,          except: %i[destroy]
  resources :product_models,     except: %i[index destroy]
  resources :product_bundles,    except: %i[index destroy]
  resources :product_categories, except: %i[destroy]
  get 'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'
end
