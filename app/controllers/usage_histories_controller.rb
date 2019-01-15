class UsageHistoriesController < ApplicationController
  def new
    @usage_history = UsageHistory.new
    @usage_history.data_confirm params[:token] if params[:PayerID].present?
  end

  def create
      if params[:usage_history]
        @usage_history = UsageHistory.new usage_history_params
        @usage_history.checkout_payment params[:usage_history][:settlement_code], params[:usage_history][:PayerID]
      end
      if @usage_history.save
        respond_to do |format|
          format.js do
            render js: "window.location.href='" + usage_history_path(@usage_history) + "'"
          end
          format.html{redirect_to @usage_history}
        end
      else
        respond_to do |format|
          format.js do
            flash[:alert] = "Error"
            render js: "window.location.href='" + new_usage_history_path + "'"
          end
          format.html{redirect_to new_usage_history_path, alert: "Error"}
        end
      end
  end

  private
  def usage_history_params
      params.require(:usage_history).permit [:amount, :used_date, :settlement_code]
  end
end
