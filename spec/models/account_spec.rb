require 'rails_helper'

RSpec.describe Account, type: :model do
  before(:example) do
    @user = create(:user, :normal)
  end

  context 'name presence' do
    before do
      Account.skip_callback(:validation, :before, :capitalize)
    end

    it 'is invalid if name not present' do
      account = Account.new(name: '', user_id: @user.id)
      expect(account).not_to be_valid
    end
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

  it 'capitalize name account' do
    account = Account.create(name: 'bank', balance: -100.15, user_id: @user.id)
    expect(account.name).to eq('Bank')
  end

  it 'is invalid if name is not unique for a user' do
    account = create(:account, user: @user)
    second = Account.new(name: account.name, balance: -100.15, user_id: @user.id)
    expect(second).not_to be_valid
  end

  it 'is valid if name is unique for user' do
    user2 = create(:user, :full_spell_count)
    account = create(:account, user: @user)
    second = Account.new(name: account.name, balance: -100.15, user_id: user2.id)
    expect(second).to be_valid
  end
end
