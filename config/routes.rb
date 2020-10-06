Rails.application.routes.draw do
  resources :appdatainfos, except: [:new, :edit]
  resources :line_items, except: [:new, :edit]
  resources :carts
  resources :users
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  get'/logout', to:'sessions#destroy'
  get '/loginUser', to: 'sessions#newuser'
  get '/seller/change', to: 'sellers#edit'
  get 'appdata', to: 'appdatainfos#dataView'

  get '/404', to: 'errors#routing'
  get '/admin', to: 'users#admin'

  resources :products
  resources :sellers
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
