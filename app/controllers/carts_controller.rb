class CartsController < ApplicationController

  
  def index
   
  end

  def payment
  	render "carts/payment"
  end


  private

  def load_cart
    @cart = current_cart
  end

  
end
