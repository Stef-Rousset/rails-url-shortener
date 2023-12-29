require 'rails_helper'
require 'debug'

RSpec.describe 'Categories', type: :system do
  before(:each) do
    @user = create(:user, :normal)
    @category = create(:category1)
    sign_in @user
  end

  it 'displays shared categories' do
    visit categories_path
    expect(page).to have_content("Liste des catégories")
    expect(page).to have_content(@category.name)
  end

  it 'adds category' do
    visit new_category_path
    expect(page).to have_content("Nouvelle catégorie")
    fill_in 'category[name]', with: 'Vacances'
    click_on('Valider')
    expect(page).to have_content("Liste des catégories")
    expect(page).to have_content("Vacances")
  end

  it 'cancels adding category' do
    visit categories_path # for cancel back link to work
    click_on('Créer une catégorie')
    expect(page).to have_content("Nouvelle catégorie")
    fill_in 'category[name]', with: 'Vacances'
    click_on('Annuler')
    expect(page).to have_content("Liste des catégories")
    expect(page).not_to have_content("Vacances")
  end
end
