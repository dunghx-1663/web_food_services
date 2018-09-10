Rails.application.routes.draw do
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get    '/foods',  to: 'foods#index'
  get    '/carts',  to: 'carts#index'
  get    '/payment',  to: 'carts#payment'

  get    'signup',  to: 'users#new'

  namespace :admin do
    root "dashboard#index", page: "index"
    # get "home", to: "dashboard#index"
  end

  devise_for :users
  root "static_pages#show", page: "home"
  resources :users
  # get "/static_pages/:page", to: "static_pages#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
