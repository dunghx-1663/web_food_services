class CartsController < ApplicationController
  def index
    render "carts/cart"
  end

  def payment
  	render "carts/payment"
  end
end
