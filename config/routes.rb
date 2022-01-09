Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses,         except: %i[destroy]
  resources :suppliers,          except: %i[destroy]
  resources :product_models,     except: %i[index destroy]
  resources :product_bundles,    except: %i[index destroy]
  resources :product_categories, except: %i[destroy]  
end
