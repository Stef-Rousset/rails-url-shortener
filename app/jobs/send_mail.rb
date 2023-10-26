require 'sidekiq-scheduler'

# Job to send news mail to user
class SendMail < ApplicationJob
  queue_as :default

  def perform
    User.joins(:sources).distinct.each do |user|
      UserMailer.with(user: user).news_email.deliver_now
    end
  end
end
