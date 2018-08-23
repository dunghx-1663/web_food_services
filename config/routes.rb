Rails.application.routes.draw do
  devise_for :annoucements
  devise_for :pictures
  devise_for :votes
  devise_for :comments
  devise_for :order_details
  devise_for :orders
  devise_for :carts
  devise_for :food_categories
  devise_for :foods
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
