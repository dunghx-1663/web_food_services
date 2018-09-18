class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: :show


  def index
   @search = User.search params[:q]
   @users = @search.result.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "admin.users.success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.users.danger"
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:info] = "Successs"
      redirect_to admin_users_url
    else
      flash[:danger] = "Fails"
      render :edit
    end
  end

  def show
    @user = User.find_by id: params[:id]
    respond_to do |format|
      format.js
    end
  end


  def destroy
    @user = User.find_by id: params[:id]
    if @user.destroy
      flash[:success] = t("Success")
      redirect_to admin_users_url
    else
      flash[:danger] = t("Fail")
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".danger"
    redirect_to root_url
  end

  def user_params
      params.require(:user).permit :name, :email, :username,
                                   :password, :password_confirmation,
                                   :address, :phone_number, :avatar_url
  end
end
