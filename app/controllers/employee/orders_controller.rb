class Employee::OrdersController < Employee::BaseController
  
  def index
    @all_orders = Order.all.paginate page: params[:page]
  end

  def create
  	@order = Order.find params[:order_id]
    @order.update_attributes status: 2
    respond_to do |format|
      format.js
    end
  end


end
