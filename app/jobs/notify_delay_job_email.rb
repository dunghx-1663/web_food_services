class NotifyDelayJobEmail < ApplicationJob
  queue_as :notify_create_store

  def perform(store)
    UserMailer.notify_delay_job_email(store).deliver
  end
end
