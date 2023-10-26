class UserMailer < ApplicationMailer
helper ApplicationHelper

  def news_email
    @user = params[:user]
    @news = @user.user_news
    mail(to: @user.email, subject: 'Your news for the day')
  end
end
