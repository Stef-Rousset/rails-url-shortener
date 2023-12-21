require 'rails_helper'

RSpec.describe AccountPolicy, type: :policy do
  before(:example) do
    @user = create(:user, :full_spell_count)
    @user2 = create(:user, :normal)
    @user2.admin = true
    @account = create(:account, user: @user)
  end

  subject { described_class }

  context 'for scope' do
    let(:policy_scope) { AccountPolicy::Scope.new(user, Account).resolve }

    context 'for normal user' do
      permissions ".scope" do
        let(:user) { @user }

        it "gives user's accounts" do
          expect(policy_scope).to eq(user.accounts)
        end
      end
    end

    context 'for admin user' do
      permissions ".scope" do
        let(:user) { @user2 }

        it "gives all accounts" do
          expect(policy_scope).to eq(Account.all)
        end
      end
    end
  end

  permissions :show?, :update?, :destroy? do
    it "denies access if account doesn't belong to user" do
      expect(subject).not_to permit(@user2, @account)
    end
    it 'grants access if account belongs to user' do
      expect(subject).to permit(@user, @account)
    end
  end

  permissions :create? do
    it 'grants access' do
      account = Account.new(name: "Bank", balance: 10, user_id: @user)
      expect(subject).to permit(@user, account)
    end
  end
end
