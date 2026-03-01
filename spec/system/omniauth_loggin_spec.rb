require 'rails_helper'
require 'byebug'

RSpec.describe 'Omniauth google', type: :system do
  let(:omniauth_user) { create(:user, :omniauth_user) }

  context "when using google to sign in" do
    let(:omniauth_hash) do
      OmniAuth::AuthHash.new(
        provider: omniauth_user.provider,
        uid: omniauth_user.uid,
        info: {
          name: omniauth_user.full_name,
          email: omniauth_user.email
        }
      )
    end

    before do
      # Once you have enabled test mode, all requests to OmniAuth
      # will be short circuited to use the mock authentication hash
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = omniauth_hash
    end

    after do
      OmniAuth.config.test_mode = false
      OmniAuth.config.mock_auth[:google_oauth2] = nil
    end

    it 'displays google loggin link' do
    visit new_user_session_path
    expect(page).to have_content("Connexion")
    expect(page).to have_css("input[src='/assets/web_neutral_sq_SI@1x.png']")
  end

    it "loggs in google user already registered" do
      visit new_user_session_path
      find("input[type='image']").click
      expect(page).to have_content("Autorisé par votre compte Google.")
      expect(page).to have_content('Voici les différents outils que vous pouvez utiliser gratuitement :)')
    end
  end

  context "when using google to sign up" do
    let(:omniauth_hash) do
      OmniAuth::AuthHash.new(
        provider: "google_oauth2",
        uid: "123545",
        info: {
          name: "Google User",
          email: "user@from-google.com"
        }
      )
    end

    before do
      # Once you have enabled test mode, all requests to OmniAuth
      # will be short circuited to use the mock authentication hash
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = omniauth_hash
    end

    after do
      OmniAuth.config.test_mode = false
      OmniAuth.config.mock_auth[:google_oauth2] = nil
    end

    it 'displays google sign up link' do
      visit new_user_registration_path
      expect(page).to have_content("S'INSCRIRE")
      expect(page).to have_css("input[src='/assets/web_neutral_sq_SU@1x.png']")
    end

    it "signs up a new google user" do
      visit new_user_registration_path
      find("input[type='image']").click
      expect(page).to have_content("Autorisé par votre compte Google.")
      expect(page).to have_content('Voici les différents outils que vous pouvez utiliser gratuitement :)')
    end

    context "and user already exists" do
      let(:omniauth_hash) do
        OmniAuth::AuthHash.new(
          provider: omniauth_user.provider,
          uid: omniauth_user.uid,
          info: {
            name: omniauth_user.full_name,
            email: omniauth_user.email
          }
        )
      end

      it "authenticates an existing user" do
        visit new_user_registration_path
        find("input[type='image']").click
        expect(page).to have_content("Autorisé par votre compte Google.")
        expect(page).to have_content('Voici les différents outils que vous pouvez utiliser gratuitement :)')
      end
    end
  end
end
