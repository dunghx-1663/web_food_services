class Employee::DashboardController < Employee::BaseController

  def index
    @foodcategories = FoodCategory.all
    # render template: "employee/dashboard/#{params[:page]}"
    @orders = Order.all
    @top_orders = load_top_order
  end
  
  # def load_top
  #   return load_top_food && load_top_order if current_user.Admin?
  #   load_top_order
  # end

  def load_top_order
    Order.order_by_time.first Settings.top_dashboard
  end


end
