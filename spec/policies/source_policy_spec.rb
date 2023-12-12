require 'rails_helper'

RSpec.describe SourcePolicy, type: :policy do
  before(:example) do
    @user = create(:user1)
    @user2 = create(:user2)
    @source = create(:source_one)
    @user.sources << @source
  end

  subject { described_class }

  context 'for scope and user' do
    let(:policy_scope) { SourcePolicy::Scope.new(user, Source).resolve }

    permissions ".scope" do
      let(:user) { @user }

      it "gives user's sources" do
        expect(policy_scope).to eq(user.sources)
      end
    end
  end

  permissions :choose_sources? do
    it "denies access if user has sources" do
      expect(subject).not_to permit(@user)
    end
    it 'grants access if if user has no sources' do
      expect(subject).to permit(@user2)
    end
  end

  permissions :edit_sources_for_user? do
    it "grants access if user has sources" do
      expect(subject).to permit(@user)
    end
    it 'denies access if user has no sources' do
      expect(subject).not_to permit(@user2)
    end
  end

  permissions :update_sources_for_user? do
    it 'grants access' do
      expect(subject).to permit(@user)
    end
  end
end
