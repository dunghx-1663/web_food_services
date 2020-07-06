# frozen_string_literal: true

class GetDataGcloud
  attr_reader :gcloud

  def initialize
    @gcloud = Gcloud.new
  end

  def perform kind, name
    glcoud.get_data_entity kind, name
  end
end
