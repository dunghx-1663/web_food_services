require "sidekiq/web"
require "sidekiq/cron/web"

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{ENV['REDIS_HOST']}:6379", namespace: "sidekiq_#{Rails.env}"
  }

  schedule_file = "config/schedule.yml"
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist? schedule_file
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{ENV['REDIS_HOST']}:6379", namespace: "sidekiq_#{Rails.env}"
  }
end

Sidekiq::Extensions.enable_delay!
