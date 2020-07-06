# frozen_string_literal: true

class InsertDataEntity
  attr_reader :gcloud

  def initialize
    @gcloud = Gcloud.new
  end

  def perform kind, name
    glcoud.insert_data_entity kind, name
  end
end
