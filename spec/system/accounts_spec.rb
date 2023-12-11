require 'rails_helper'

RSpec.describe 'Accounts', type: :system do
  before(:example) do
    @user = create(:user1)
    @account = create(:account, user: @user)
    sign_in @user
  end

    it 'shows index page' do
      visit accounts_path
      expect(page).to have_content('Mes comptes')
    end

    it 'deletes account from index' do
      visit accounts_path
      expect(page).to have_content('Mes comptes')
      expect(page).to have_content(@account.name)
      find('.fa-trash-can').click
      page.driver.browser.switch_to.alert.accept # accept the alert_modal "Are you sure?"
      expect(page).not_to have_content(@account.name)
    end

    it 'gives access to page show from index' do
      visit accounts_path
      expect(page).to have_content('Mes comptes')
      click_on 'Détails'
      expect(page).to have_content("Détails du compte #{@account.name}")
    end

    it 'redirects to index from show' do
      visit "fr/accounts/#{@account.id}"
      expect(page).to have_content("Détails du compte #{@account.name}")
      click_on 'Retour à la liste'
      expect(page).to have_content('Mes comptes')
    end

    it 'gives access to page new from index' do
      visit accounts_path
      expect(page).to have_content('Mes comptes')
      click_on 'Créer un compte'
      expect(page).to have_content('Nouveau compte')
    end

    it 'creates a new account' do
      visit new_account_path
      expect(page).to have_content('Nouveau compte')
      fill_in 'account[name]', with: 'Banque postale'
      fill_in 'account[balance]', with: '100'
      click_on 'Valider'
      expect(page).to have_content('Détails du compte Banque postale')
      expect(page).to have_content('Solde : 100,00 €')
    end

    it 'redirects to index from new' do
      visit new_account_path
      expect(page).to have_content('Nouveau compte')
      click_on 'Annuler'
      expect(page).to have_content('Mes comptes')
    end

    it 'updates account' do
      visit "fr/accounts/#{@account.id}/edit"
      expect(page).to have_content('Modifier le compte')
      fill_in 'account[name]', with: '' #needed to empty input filled with old value
      fill_in 'account[name]', with: 'Nouveau nom'
      click_on 'Valider'
      expect(page).to have_content('Détails du compte Nouveau nom')
    end
end
