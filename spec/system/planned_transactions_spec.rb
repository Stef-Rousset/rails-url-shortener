require 'rails_helper'

RSpec.describe 'PlannedTransactions', type: :system do
  before(:each) do
    @user = create(:user, :normal)
    @account = create(:account, user: @user)
    @planned = create(:planned_transaction, :every_month, account: @account)
    sign_in @user
  end

  it 'displays planned_transactions' do
    visit planned_transactions_path
    expect(page).to have_content('Opérations planifiées')
    expect(page).to have_content(@planned.payee)
  end

  it 'adds planned_transactions' do
    visit new_planned_transaction_path
    expect(page).to have_content('Nouvelle opération planifiée')
    fill_in 'planned_transaction[start_date]', with: Date.today + 1.day
    select('mois', from: 'planned_transaction_every')
    fill_in 'planned_transaction[payee]', with: 'taxe'
    select("#{@account.name}", from: 'planned_transaction_account_id')
    select('débit', from: 'planned_transaction_transaction_type')
    fill_in 'planned_transaction[amount]', with: 10.0
    click_on('Valider')
    expect(page).to have_content('Opérations planifiées')
    expect(page).to have_content('taxe')
  end

  it 'cancels adding category' do
    visit planned_transactions_path # for cancel back link to work
    click_on('Planifier une opération')
    expect(page).to have_content('Nouvelle opération planifiée')
    fill_in 'planned_transaction[payee]', with: 'taxe'
    click_on('Annuler')
    expect(page).to have_content('Opérations planifiées')
    expect(page).not_to have_content('taxe')
  end
end
