require 'rails_helper'

RSpec.describe Account, type: :model do
  before(:example) do
    @user = create(:user1)
  end
  it 'is invalid if name not present' do
    account = Account.new(name: '', user_id: @user.id)
    expect(account).not_to be_valid
  end

  it 'is valid if name is  present' do
    account = Account.new(name: 'bank', user_id: @user.id)
    expect(account).to be_valid
  end

  it 'gets a balance default value of 0' do
    account = Account.new(name: 'bank', user_id: @user.id)
    expect(account.balance).to eq(0.0)
  end

  it 'is invalid if balance is not a number' do
    account = Account.new(name: 'bank', balance: 'string', user_id: @user.id)
    expect(account).not_to be_valid
  end

  it 'is valid if balance is a number' do
    account = Account.new(name: 'bank', balance: -100.15, user_id: @user.id)
    expect(account).to be_valid
  end
end
