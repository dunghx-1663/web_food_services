Rails.application.routes.draw do
  devise_for :users
  root "static_pages#show", page: "home"
  # get "/static_pages/:page", to: "static_pages#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
