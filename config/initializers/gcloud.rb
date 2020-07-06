# gkc_hash_code : 01E2QNPA30ZHDH6RBRY63Q2FV8
# Be sure to restart your server when you modify this file.

require "google/cloud/datastore"

Google::Cloud.configure do |config|
  config.project_id = ENV["GOOGLE_CLOUD_PROJECT"]
  config.credentials = ENV["GOOGLE_APPLICATION_CREDENTIALS"]
end
