class Admin::FoodCategoriesController < Admin::BaseController
  before_action :load_food_category, only: :show

  def index
   @search = FoodCategory.search params[:q]
   @foodcategories = @search.result.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
  end

  def new
    @foodcategory = FoodCategory.new
  end

  def edit
    @foodcategory = FoodCategory.find_by id: params[:id]
  end

  def create
    @foodcategory = FoodCategory.new food_category_params
    if @foodcategory.save
      flash[:success] = t "admin.success"
      redirect_to admin_food_categories_path
    else
      flash[:danger] = t "admin.danger"
      render :new
    end
  end
 
  def update
    @foodcategory = FoodCategory.find_by id: params[:id]
    if @foodcategory.update_attributes food_category_params
      flash[:info] = "Successs"
      redirect_to admin_food_categories_url
    else
      flash[:danger] = "Fails"
      render :edit
    end
  end

  def destroy
    @foodcategory = FoodCategory.find_by id: params[:id]
    if @foodcategory.foods.any?
      flash[:danger] = t ".delete.cannot_delete"
    else
      if @foodcategory.destroy
        flash[:success] = t("Success")
      else
        flash[:danger] = t("Fail")
      end
    end
    redirect_to admin_food_categories_url
  end

  private

  def load_food_category
    @foodcategory = FoodCategory.find_by id: params[:id]
    return if @foodcategory
    flash[:danger] = t ".danger"
    redirect_to root_url
  end

  def food_category_params
      params.require(:food_category).permit :name, :description
  end
end