class CartsController < ApplicationController
  def create
    if logged_in?
      @cart = Cart.find_or_create_by(user_id: current_user.id, food_id: params[:food_id])
    else
      @cart = Cart.find_or_create_by(session_id: request.session_options[:id], food_id: params[:food_id])
    end
    if @cart.quantity
      quantity = @cart.quantity + params[:quantity].to_i
      @cart.update_attributes(quantity: quantity)
      binding.pry

    else
      @cart.quantity = params[:quantity]
      @cart.save
    end
    respond_to do |format|
      format.js
    end
  end

  def index
    @q = Food.ransack(params[:q])
    @categories = FoodCategory.all
    if current_user.present?
      @carts = current_user.carts
    else
      @carts = Cart.cart_amount_session request.session_options[:id]
    end
  end

  def update
    params[:cart][:items].each do |index|
      cart = Cart.find(params[:cart][:items][index][:id])
      price_promote = cart.food.price - cart.food.discount.to_f/Settings.percentage * cart.food.price
      cart.update_attributes(quantity: params[:cart][:items][index][:quantity],total_money: price_promote * params[:cart][:items][index][:quantity].to_f)
      # price - discount.to_f/Settings.percentage * price
      binding.pry
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    @cart_id = params[:id]
    respond_to do |format|
      format.html {redirect_to carts_url}
      format.js
    end
  end
end
