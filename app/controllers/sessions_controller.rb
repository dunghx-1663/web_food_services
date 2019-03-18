class SessionsController < ApplicationController
  layout false
  def new
    @categories = FoodCategory.all
    render "shared/_form_login"
  end

  def create
    @categories = FoodCategory.all
    user = User.find_by email: params[:session][:email]
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        if user.Admin? 
          flash[:success] = "Welcome admin"
          redirect_to admin_root_url
        elsif user.Employee?
          flash[:success] = "Welcome Employee"
          redirect_to employee_root_url
        else
          flash[:success] = "Welcome"
          # redirect_back_or root_url
          redirect_to user
        end
      else
        message  = t "sessions.create.account_not_activated"
        message += t "sessions.create.check_email"
        flash[:warning] = message
        redirect_to root_url
      end 
    else
      flash[:danger] = "Invalid account"
      render 'shared/_form_login'
    end
  end

  def signup
    @categories = FoodCategory.all
  	@user = User.new
  	render "shared/_form_signup"
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_url
  end
end
