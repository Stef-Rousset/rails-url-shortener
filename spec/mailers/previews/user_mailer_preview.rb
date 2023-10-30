# Preview all emails at http://localhost:3000/rails/mailers/user_mailer/
class UserMailerPreview < ActionMailer::Preview

  def news_email
    UserMailer.with(user: User.first).news_email
  end
end
