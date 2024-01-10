# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE), not null
#  spell_count            :integer          default(0), not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user, :normal)
    @source = create(:source_one)
    @user.sources << @source
  end

  it "returns a hash with user's sources news" do
    hash = @user.user_news
    expect(hash.class).to eq(Hash)
    expect(hash.keys).to eq(['lemonde'])
    expect(hash.values.flatten.size).to eq(5)
  end

  it 'normalizes email' do
    user = User.create(email: 'BLA@gmail.com', password: 'blabla')
    expect(user.email).to eq('bla@gmail.com')
  end

  it 'sums the balance of user accounts' do
    account = create(:account, user: @user)
    account2 = Account.create(name: 'poste', balance: - 5.0, user_id: @user.id)
    expect(@user.accounts_total_sum).to eq(account.balance + account2.balance)
  end
end
