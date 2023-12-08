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

  it 'gives the previous transaction if there is one or nil if there is not' do
    transaction = create(:transaction1, account: @account) # date 29 nov
    second = create(:transaction2, account: @account) # date 1 dec
    expect(transaction.previous_transaction).to eq(second)
    expect(second.previous_transaction).to eq(nil)
  end

  it 'updates balance account when transaction is created' do
    expect(@account.balance).to eq(9.99)
    transaction = Transaction.create(payee: 'Paul', date: Date.today, amount: 10, transaction_type: 1, account_id: @account.id)
    @account.reload
    expect(@account.balance).to eq(19.99)
  end

  it 'updates balance account with update_balance_after_destroy' do
    expect(@account.balance).to eq(9.99)
    transaction = Transaction.create(payee: 'Paul', date: Date.today, amount: 10, transaction_type: 1, account_id: @account.id)
    @account.reload
    expect(@account.balance).to eq(19.99)
    transaction.update_balance_after_destroy
    @account.reload
    expect(@account.balance).to eq(9.99)
  end

  it 'updates balance account with update_balance_if_changes_on_amount_or_type' do
    expect(@account.balance).to eq(9.99)
    transaction = create(:transaction2, account: @account)
    @account.reload
    expect(@account.balance).to eq(0.0)
    transaction.update(amount: 19.99)
    @account.reload
    expect(@account.balance).to eq(- 10.0)
    transaction.update(transaction_type: 1)
    @account.reload
    expect(@account.balance).to eq(29.98)
    transaction.update(amount: 15.99, transaction_type: 0)
    expect(@account.balance).to eq(- 6.0)
  end
end
