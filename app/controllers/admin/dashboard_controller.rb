class Admin::DashboardController < Admin::BaseController

  def index
    render template: "admin/dashboard/#{params[:page]}"
  end

end
