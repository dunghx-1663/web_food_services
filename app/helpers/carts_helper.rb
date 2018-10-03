module CartsHelper
  def current_cart
    if session[:cart_id].present?
      Cart.find_by id: session[:cart_id]
    else
      Cart.create
    end
  end
end
