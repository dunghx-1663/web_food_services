class VotesController < ApplicationController
  def create
    @vote = Vote.find_or_create_by(user_id: current_user.id, food_id: params[:food_id])
    @vote.update_attributes rating: params[:vote]
    if @vote.save
      respond_to do |format|
       format.js
      end
    end
  end

end
