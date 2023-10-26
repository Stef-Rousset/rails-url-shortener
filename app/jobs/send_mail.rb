require 'sidekiq-scheduler'

class SendMail < ApplicationJob
  queue_as :default

  def perform(*args)
    User.joins(:sources).distinct.each do |user|
      UserMailer.with(user: user).news_email.deliver_now
    end
  end
end
