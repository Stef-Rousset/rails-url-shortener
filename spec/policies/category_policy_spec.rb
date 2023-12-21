require 'rails_helper'

RSpec.describe CategoryPolicy, type: :policy do
  before(:example) do
    @user = create(:user, :full_spell_count)
    @user2 = create(:user, :normal)
    @user2.admin = true
    @cate = create(:category, user: @user)
  end

  subject { described_class }

  context 'for scope' do
    let(:policy_scope) { CategoryPolicy::Scope.new(user, Category).resolve }

    context 'for normal user' do
      permissions ".scope" do
        let(:user) { @user }
        let(:category) { Category.create(name: 'test', user_id: nil) }

        it "gives user's categories plus categories with user_id nil" do
          expect(policy_scope).to eq(user.categories << category)
        end
      end
    end

    context 'for admin user' do
      permissions ".scope" do
        let(:user) { @user2 }
        let(:category) { Category.create(name: 'test', user_id: nil) }

        it "gives all categories" do
          expect(policy_scope).to eq(Category.all)
        end
      end
    end
  end

  permissions :create? do
    it 'grants access to create' do
      new_cate = Category.new(name: 'test', user_id: @user.id)
      expect(subject).to permit(@user, new_cate)
    end
  end

  permissions :destroy? do
    it "denies access if category doesn't belong to user" do
      expect(subject).not_to permit(@user, Category.new(name: 'voiture', user_id: nil))
    end
    it 'grants access if category belongs to user' do
      expect(subject).to permit(@user, @cate)
    end
  end
end

