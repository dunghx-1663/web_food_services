class Admin::FoodsController < Admin::BaseController
  before_action :load_food, only: :show

  def index
   @search = Food.search params[:q]
   @foods = @search.result.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
  end

  def new
    @food = Food.new
    @foodcategories = FoodCategory.all
  end

  def create
    @food = Food.new food_params
    if @food.save
      flash[:success] = t "admin.success"
      redirect_to admin_foods_path
    else
      flash[:danger] = t "admin.danger"
      render :new
    end
  end

  def edit
    @food = Food.find_by id: params[:id]
    @foodcategories = FoodCategory.all
  end

  def update
    @food = Food.find_by id: params[:id]
    if @food.update_attributes food_params
      flash[:info] = "Successs"
      redirect_to admin_foods_url
    else
      flash[:danger] = "Fails"
      render :edit
    end
  end

  def show
    @food = Food.find_by id: params[:id]
    respond_to do |format|
      format.js
    end
  end


  def destroy
    @food = Food.find_by id: params[:id]
    if @food.destroy
      flash[:success] = t("Success")
      redirect_to admin_foods_url
    else
      flash[:danger] = t("Fail")
    end
  end

  private

  def load_food
    @food = Food.find_by id: params[:id]
    return if @food
    flash[:danger] = t ".danger"
    redirect_to root_url
  end

  def food_params
      params.require(:food).permit :name, :img_url, :price, :discount,
                                   :rating_avg, :description, :food_category_id
  end
end
