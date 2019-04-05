class OrdersController < ApplicationController
  def index
    @q = Food.ransack(params[:q])
    @categories = FoodCategory.all
    if logged_in?
      if current_user.shipper?
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
      elsif current_user.admin?
        @orders = Order.deliveried_in_month
        respond_to do |format|
          format.html
          format.xls
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
    @q = Food.ransack(params[:q])
    @categories = FoodCategory.all
    @order = Order.new
    @orders = current_user.carts
  end

  def create
    carts = Cart.cart_order current_user.id
    order_details = to_hash carts
    if params[:order][:address].present?
      address = params[:order][:address]
    else
      address = current_user.address
    end
    order = Order.new(
        customer_id: current_user.id,
        status: Settings.status.new_order,
        address: address,
        total_money: Cart.total(current_user.id),
        order_details_attributes: order_details
    )
    # gửi thông báo email khi đặt đơn hàng thành côg
    # UserMailer.order_mail(current_user).deliver
    if order.save
      current_user.carts.delete_all
      redirect_to root_url
      flash[:success] = t "controllers.orders.create.success"
    else
      redirect_to request.referrer || root_url
      flash[:info] = t "controllers.orders.create.lost_info"
    end
  end

  def destroy
    order = Order.find params[:id]
    order.destroy
    @order_id = params[:id]
    if order.destroy
      respond_to do |format|
        format.html {redirect_to orders_url}
        format.js
      end
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
