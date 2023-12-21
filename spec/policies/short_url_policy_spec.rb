require 'rails_helper'

RSpec.describe ShortUrlPolicy, type: :policy do
  before(:example) do
    @user = create(:user, :full_spell_count)
    @user2 = create(:user, :normal)
    @user2.admin = true
    @url = create(:short_url, :with_tiny_url, user: @user)
  end

  subject { described_class }

  context 'for scope' do
    let(:policy_scope) { ShortUrlPolicy::Scope.new(user, ShortUrl).resolve }

    context 'for normal user' do
      permissions ".scope" do
        let(:user) { @user }

        it "gives user's urls" do
          expect(policy_scope).to eq(user.short_urls)
        end
      end
    end

    context 'for admin user' do
      permissions ".scope" do
        let(:user) { @user2 }

        it "gives all urls" do
          expect(policy_scope).to eq(ShortUrl.all)
        end
      end
    end
  end

  permissions :show?, :destroy? do
    it "denies access if short_url doesn't belong to user" do
      expect(subject).not_to permit(@user2, @url)
    end
    it 'grants access if short_url belongs to user' do
      expect(subject).to permit(@user, @url)
    end
  end

  permissions :create? do
    it 'grants access' do
      url = ShortUrl.new(long_url: 'https://www.ffescrime.fr/je-suis-en-club/competiteurs/reglements/', tiny_url: '', user_id: @user)
      expect(subject).to permit(@user, url)
    end
  end
end
