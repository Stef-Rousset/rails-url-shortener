require 'rails_helper'

RSpec.describe "Pages", type: :system do
  before(:each) do
    @user = create(:user1)
    @user2 = create(:user2)
  end

  context 'not signed in' do
    it 'shows home page' do
      visit root_path
      expect(page).to have_content('Bienvenue sur Mes outils partagés !')
    end

    it 'shows about page with back button to homepage and without navbar hamburger' do
      visit about_path
      expect(page).to have_content('À propos de ce site')
      expect(page).to have_content("Retour à l'accueil") #back button if not signed_in
      expect(page.has_css?('button#button')).to eq(false)# no hamburger button if not signed_in
    end
  end

  context 'signed in with @user' do
    before do
      sign_in @user
    end

    it 'shows home page' do
      visit root_path
      expect(page).to have_content('Bienvenue sur Mes outils partagés !')
    end

    it 'shows about page with navbar hamburger and without back button' do
      visit about_path
      expect(page).to have_content('À propos de ce site')
      expect(page).not_to have_content("Retour à l'accueil") # no back button if signed_in
      expect(page.has_css?('button#button')).to eq(true) # hamburger button if signed_in
    end

    it 'redirects to home page via navbar hamburger' do
      visit about_path
      find('button#button').click
      # wrap capybara finders inside of a within block for test to wait
      # until it finds that within selector FIRST before trying to run the code inside of it.
      within '#navbar-hamburger' do
        find('#link_test').click # link to home page
      end
      expect(page).to have_content('Bienvenue sur Mes outils partagés !')
    end

    it 'shows the weather page and give meteo infos after submitting form' do
      visit weather_path
      expect(page).to have_content('Prévisions méteo')
      fill_in 'search', with: 'paris'
      click_on 'Valider'
      expect(find('#td_test')).to have_text(/\w/) # presence of text added in JS
      expect(find('#no_text')).not_to have_text(/\w/) # element always without text
    end
  end

  context 'signed in with @user2' do
    before do
      sign_in @user2 # it has spell_count = 0
    end

    it 'shows the spell_checker page and give the correct word after submitting form' do
      visit spell_checker_path
      expect(page).to have_content("Vérificateur d'ortographe")
      fill_in 'search', with: 'bouteile'
      choose('french') # choose a radio button with a name, id, or label text matching french
      click_on 'Valider'
      expect(page).to have_text('bouteille', wait: 15)
    end

    it 'answers in english in english language is selected' do
      visit spell_checker_path
      expect(page).to have_content("Vérificateur d'ortographe")
      fill_in 'search', with: 'botle'
      choose('english')
      click_on 'Valider'
      expect(page).to have_text('bottle', wait: 15)
    end
  end
end
