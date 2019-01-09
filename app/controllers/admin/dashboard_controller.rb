class Admin::DashboardController < Admin::BaseController

  # def index
  #   render template: "admin/dashboard/#{params[:page]}"
  # end

  def index
    @users = User.all
    @orders = Order.all
    @top_orders = load_top_order
    @top_foods = load_top_food
  end
  
  # def load_top
  #   return load_top_food && load_top_order if current_user.Admin?
  #   load_top_order
  # end

  def load_top_order
    Order.order_by_time.first Settings.top_dashboard
  end

  def load_top_food
    Food.order_by_time.first Settings.top_dashboard
  end

end
