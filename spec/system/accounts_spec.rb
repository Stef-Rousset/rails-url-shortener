require 'rails_helper'

RSpec.describe 'Accounts', type: :system do
  before(:example) do
    @user = create(:user, :normal)
    @account = create(:account, user: @user)
    @category1 = create(:category3, user: @user)
    @category2 = create(:category4, user: @user)
    @transaction1 = create(:transaction1, account: @account, category: @category1)
    @transaction2 = create(:transaction2, account: @account, category: @category2)

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

    it 'shows the transactions belonging to account' do
      visit "fr/accounts/#{@account.id}"
      expect(page).to have_content("Détails du compte #{@account.name}")
      expect(page).to have_content(@transaction1.payee)
      expect(page).to have_content(@transaction2.payee)
    end

    it 'shows transactions filtered by categories' do
      visit "fr/accounts/#{@account.id}"
      expect(page).to have_content("Détails du compte #{@account.name}")
      select('Salaire', from: 'category_id')
      click_on 'Valider'
      expect(page).to have_content(@transaction1.payee)
      expect(page).not_to have_content(@transaction2.payee)
    end

    it 'shows transactions filtered by checked' do
      visit "fr/accounts/#{@account.id}"
      expect(page).to have_content("Détails du compte #{@account.name}")
      find('.filter-checked').click
      click_on 'Valider'
      expect(page).not_to have_content(@transaction1.payee) # checked is false
      expect(page).to have_content(@transaction2.payee) # checked is true
    end

    it 'shows transactions with date >= begin_date' do
      visit "fr/accounts/#{@account.id}"
      expect(page).to have_content("Détails du compte #{@account.name}")
      fill_in 'begin_date', with: '01/12/2023'
      click_on 'Valider'
      expect(page).not_to have_content(@transaction1.payee) # date is 2023-11-29
      expect(page).to have_content(@transaction2.payee) # date is 2023-12-01
    end

    it 'shows transactions with date <= end_date' do
      visit "fr/accounts/#{@account.id}"
      expect(page).to have_content("Détails du compte #{@account.name}")
      fill_in 'end_date', with: '29/11/2023'
      click_on 'Valider'
      expect(page).to have_content(@transaction1.payee) # date is 2023-11-29
      expect(page).not_to have_content(@transaction2.payee) # date is 2023-12-01
    end

    it 'shows transactions with date between begin_date and end_date' do
      visit "fr/accounts/#{@account.id}"
      expect(page).to have_content("Détails du compte #{@account.name}")
      fill_in 'begin_date', with: '25/11/2023'
      fill_in 'end_date', with: '30/11/2023'
      click_on 'Valider'
      expect(page).to have_content(@transaction1.payee) # date is 2023-11-29
      expect(page).not_to have_content(@transaction2.payee) # date is 2023-12-01
    end

    it 'shows transaction filtered by combined criterias' do
      visit "fr/accounts/#{@account.id}"
      expect(page).to have_content("Détails du compte #{@account.name}")
      fill_in 'begin_date', with: '01/01/2023' # dates matches both transactions
      fill_in 'end_date', with: '31/12/2023'
      select('Cadeaux', from: 'category_id') # category match only transaction2
      click_on 'Valider'
      expect(page).not_to have_content(@transaction1.payee)
      expect(page).to have_content(@transaction2.payee)
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
      expect(page).to have_content('Solde : 100 €')
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
