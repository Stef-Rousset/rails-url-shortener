require 'rails_helper'

RSpec.describe TransactionPolicy, type: :policy do
  before(:example) do
    @user = create(:user1)
    @user2 = create(:user2)
    @account = create(:account, user: @user)
    @transaction = create(:transaction1, account: @account)
    @trans2 = create(:transaction2, account: @account)
    @trans2.checked = true
  end

  subject { described_class }

  permissions :create? do
    it 'grants access' do
      transaction = Transaction.new(account_id: @account.id, payee: "test", amount: 5.99, date: "2023-11-29", transaction_type: 0)
      expect(subject).to permit(@user, transaction)
    end
  end

  permissions :edit?, :destroy? do
    it "denies access if transaction doesn't belong to user" do
      expect(subject).not_to permit(@user2, @transaction)
    end

    it "denies access if transaction is checked" do
      expect(subject).not_to permit(@user, @trans2)
    end

    it 'grants access if transaction belongs to user and is not checked' do
      expect(subject).to permit(@user, @transaction)
    end
  end

  permissions :update?, :update_checked? do
    it "denies access if transaction doesn't belong to user" do
      expect(subject).not_to permit(@user2, @transaction)
    end
    it 'grants access if transaction belongs to user' do
      expect(subject).to permit(@user, @transaction)
    end
  end
end
