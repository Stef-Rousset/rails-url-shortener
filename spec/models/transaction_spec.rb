require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:example) do
    @user = create(:user1)
    @account = create(:account, user: @user)
  end

  it 'is invalid if transaction_type is absent' do
    trans = Transaction.new(payee: 'Paul', date: Date.today, amount: 10, account_id: @account.id)
    expect(trans).not_to be_valid
  end

  it 'is invalid if payee is absent' do
    trans = Transaction.new(payee: '', date: Date.today, amount: 10, transaction_type: 1, account_id: @account.id)
    expect(trans).not_to be_valid
  end

  it 'is invalid if date is absent' do
    trans = Transaction.new(payee: 'Paul', date: nil, amount: 10, transaction_type: 1, account_id: @account.id)
    expect(trans).not_to be_valid
  end

  it 'is valid if payee, date and transaction_type are present' do
    trans = Transaction.new(payee: 'Paul', date: Date.today, amount: 10, transaction_type: 0,account_id: @account.id)
    expect(trans).to be_valid
  end
end
