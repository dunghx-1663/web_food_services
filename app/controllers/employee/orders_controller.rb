class Employee::OrdersController < Employee::BaseController
  
  def index
    @all_orders = Order.all.paginate page: params[:page]
  end

  def filter_order_status
    @categories = FoodCategory.all
    if logged_in?
      if current_user.Employee?
        if params[:orders].present?
          if params[:orders] == "inprogress"
            @orders = Order.inprogress
          elsif params[:orders] == "new"
            @orders = Order.new_order
          elsif params[:orders] == "done"
            @orders = Order.done
          end
        else
          @orders = Order.all
        end
      else
        @orders = Order.ordered_by(current_user.id).includes(:order_details)
      end
    else
      flash[:danger] = t "views.orders.danger"
      redirect_to root_path
    end
  end

  def show
    @order = Order.find params[:id]
  end

  def new
    @categories = FoodCategory.all
    @order = Order.new
    @orders = current_user.carts
  end
  # update status when pick orders
  def create   
    @order = Order.find params[:order_id]
    @order.update_columns status: 2, employee_id: current_user.id
    respond_to do |format|
      format.js
    end
  end
  
  def done_order
    @order = Order.find params[:order_id]
    if @order 
      @order.update_attributes status: 3
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "views.orders.check.error"
      redirect_to orders_url
    end
  end

  def update
    @order = Order.find params[:order_id]
    if @order
      @order.update_attributes status: Settings.status.done
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "views.orders.check.error"
      redirect_to orders_url
    end
  end

  private
  def to_hash relation
    relation.map(&:attributes)
  end


end