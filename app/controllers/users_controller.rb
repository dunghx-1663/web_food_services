class UsersController < ApplicationController
  
  def index
  	render "static_pages/home"
  end

  def show
	@user = User.find_by id: params[:id]
  end

  def new
	@user = User.new
	render "shared/_form_signup"
  end
  
  def create
  	@user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the my web!"
      redirect_to @user
    else
      render 'shared/_form_signup'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
