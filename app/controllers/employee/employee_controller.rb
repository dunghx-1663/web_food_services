class Employee::EmployeeController < Employee::BaseController
  layout "employee_header"
  before_action :verify_employee

  def verify_employee
    return if current_user.employee?
    flash[:danger] = t "Employee.danger"
    redirect_to root_path
  end
end
