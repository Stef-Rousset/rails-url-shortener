require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before(:each) do
    @user = create(:user1)
    @mail = UserMailer.with(user: @user).news_email
  end

  it 'renders the receiver email' do
    expect(@mail.to).to eq([@user.email])
  end

  it 'renders the sender' do
    expect(@mail.from).to eq('Mes outils partagés')
  end

  it 'renders the subject' do
    expect(@mail.subject).to eq('Your news for the day')
  end
end
