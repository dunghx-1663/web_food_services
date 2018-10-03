class FoodsController < ApplicationController
  
  
  def show
    @food = Food.find_by id: params[:id]
  end

  def index
    @foods = Food.all
  end


  private

  def food_params
      params.require(:food).permit :name, :img_url, :price,
                                   :rating_avg, :description, :food_category_id
  end

end
