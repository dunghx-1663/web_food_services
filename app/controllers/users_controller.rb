class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    # render "static_pages/home"
    @users = User.paginate(page: params[:page])
  end

  def show
    @q = Food.ransack(params[:q])
    @categories = FoodCategory.all
	  @user = User.find_by id: params[:id]
  end

  def new
    layout false
    @categories = FoodCategory.all
  	@user = User.new
  	render "shared/_form_signup"
  end
  
  def create
    @q = Food.ransack(params[:q])
    @categories = FoodCategory.all
    @user = User.new(user_params)
    
    if @user.save
      @user.send_activation_email
      # log_in @user
      # flash[:success] = "Welcome to the my web!"
      flash[:info] = t "users.create.confirm_email"
      redirect_to @user
    else
      render 'shared/_form_signup'
    end
  end

  def edit
    @q = Food.ransack(params[:q])
    @categories = FoodCategory.all
    @user = User.find_by id: params[:id]
    # redirect_to root_url unless correct_user
  end

  def update
    @user = User.find_by id: params[:id]

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :username,
                                   :password, :password_confirmation,
                                   :address, :phone_number, :avatar_url
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find_by id: params[:id]
      redirect_to(root_url) unless current_user?(@user)
    end
end
