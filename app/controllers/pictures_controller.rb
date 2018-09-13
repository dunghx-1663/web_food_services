class PicturesController < ApplicationController
  before_action :load_picture, only: %i(show edit update destroy)

  def new
    @picture = Picture.new
  end

  private
  def load_picture
    @picture = Picture.find_by id: params[:id] || not_found
  end

  def post_attachment_params
    params.require(:picture).permit :food_id, :image
  end
end
