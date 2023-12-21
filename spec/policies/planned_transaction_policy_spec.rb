require 'rails_helper'

RSpec.describe PlannedTransactionPolicy, type: :policy do
  before(:example) do
    @user = create(:user, :full_spell_count)
    @user2 = create(:user, :normal)
    @user2.admin = true
    @account = create(:account, user: @user)
    @planned = create(:planned_transaction, :every_day, account: @account)
  end

  subject { described_class }

  context 'for scope' do
    let(:policy_scope) { PlannedTransactionPolicy::Scope.new(user, PlannedTransaction).resolve }

    context 'for normal user' do
      permissions ".scope" do
        let(:user) { @user }

        it "gives user's planned transactions" do
          expect(policy_scope).to eq(PlannedTransaction.where(account_id: user.accounts.map(&:id)))
        end
      end
    end

    context 'for admin user' do
      permissions ".scope" do
        let(:user) { @user2 }

        it "gives all accounts" do
          expect(policy_scope).to eq(PlannedTransaction.all)
        end
      end
    end
  end

  permissions :new? do
    it 'denies access if user has no account' do
      expect(subject).not_to permit(@user2)
    end

    it 'grants access if user has account' do
      expect(subject).to permit(@user, @account)
    end
  end

  permissions :create? do
    it 'grants access' do
      planned = PlannedTransaction.new(payee: 'test', amount: 5.0, start_date: Date.today + 1.day, transaction_type: 0, every: 0, account_id: @account.id)
      expect(subject).to permit(@user, planned)
    end
  end

  permissions :edit?, :update?, :destroy? do
    it 'denies access if planned_transaction does not belong to account of current_user' do
      expect(subject).not_to permit(@user2, @planned)
    end

    it 'grants access if planned_transaction belongs to account of current_user' do
      expect(subject).to permit(@user, @planned)
    end
  end
end
