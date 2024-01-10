# == Schema Information
#
# Table name: planned_transactions
#
#  id               :bigint           not null, primary key
#  payee            :string           not null
#  amount           :decimal(11, 2)   default(0.0)
#  start_date       :date             not null
#  description      :text
#  transaction_type :integer          not null
#  every            :integer          not null
#  account_id       :bigint           not null
#  category_id      :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe PlannedTransaction, type: :model do
  before(:example) do
    @user = create(:user, :normal)
    @account = create(:account, user: @user)
  end

  it 'is invalid if payee is absent' do
    planned = PlannedTransaction.new(payee: '', amount: 5.0, start_date: Date.today, transaction_type: 0, every: 0, account_id: @account.id)
    expect(planned).not_to be_valid
  end

  it 'is invalid if amount is not a decimal' do
    planned = PlannedTransaction.new(payee: 'test', amount: 'douze', start_date: Date.today + 1.day, transaction_type: 0, every: 0, account_id: @account.id)
    expect(planned).not_to be_valid
  end

  it 'is invalid if amount is not greater than 0' do
    planned = PlannedTransaction.new(payee: 'test', amount: - 5.55, start_date: Date.today + 1.day, transaction_type: 0, every: 0, account_id: @account.id)
    expect(planned).not_to be_valid
  end

  it 'is invalid if start_date is not greater than today' do
    planned = PlannedTransaction.new(payee: 'test', amount: 5.0, start_date: Date.today, transaction_type: 0, every: 0, account_id: @account.id)
    expect(planned).not_to be_valid
  end

  it 'is invalid if transaction_type is absent' do
    planned = PlannedTransaction.new(payee: 'test', amount: 5.0, start_date: Date.today + 1.day, transaction_type: nil, every: 0, account_id: @account.id)
    expect(planned).not_to be_valid
  end

  it 'is invalid if every is absent' do
    planned = PlannedTransaction.new(payee: 'test', amount: 5.0, start_date: Date.today + 1.day, transaction_type: 0, every: nil, account_id: @account.id)
    expect(planned).not_to be_valid
  end

  it 'is valid if all required fields are ok' do
    planned = PlannedTransaction.new(payee: 'test', amount: 5.0, start_date: Date.today + 1.day, transaction_type: 0, every: 0, account_id: @account.id)
    expect(planned).to be_valid
  end
end
