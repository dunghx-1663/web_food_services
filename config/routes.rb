Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  
  get    '/payment',  to: 'carts#payment'

  get    'signup',  to: 'sessions#signup'

  namespace :admin do
    root "dashboard#index", page: "index"
    # get "home", to: "dashboard#index"
    resources :users
    resources :food_categories
    resources :foods
    resources :orders
  end

  namespace :employee do
    root "dashboard#index", page: "employee"
    resources :users
    resources :orders
    get 'orderstatus', to: 'orders#filter_order_status'
    post 'orders/done_order', to: 'orders#done_order'
  end

  devise_for :users
  root "foods#index"
  resources :users
  resources :foods
  resources :orders
  patch "carts", to: "carts#update"
  resources :carts
  resources :comments
  resources :votes, only: [:create, :update]
  # get "/static_pages/:page", to: "static_pages#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
