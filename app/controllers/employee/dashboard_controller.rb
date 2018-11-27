class Employee::DashboardController < Employee::BaseController

  def index
    @foodcategories = FoodCategory.all
    # render template: "employee/dashboard/#{params[:page]}"
  end

end
