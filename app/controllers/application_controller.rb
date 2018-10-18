class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include CommentsHelper
  include CartsHelper
  include FoodsHelper

  def not_found
    raise ActiveRecord::RecordNotFound, t(:not_found)
  rescue StandardError
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
