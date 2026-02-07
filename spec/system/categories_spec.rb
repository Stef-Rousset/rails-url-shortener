require 'rails_helper'
require 'byebug'

RSpec.describe 'Categories', type: :system do
  before(:each) do
    @user = create(:user, :normal)
    sign_in @user
  end

  it 'displays shared categories' do
    cate = create(:category3, user: @user)
    visit categories_path
    expect(page).to have_content("Liste des catégories")
    expect(page).to have_content(cate.name)
  end

  it 'adds category' do
    visit categories_path # for cancel back link to be defined
    expect(page).to have_content("Liste des catégories")
    click_on('Créer une catégorie')
    expect(page).to have_content("Nouvelle catégorie")
    fill_in 'category[name]', with: 'Vacances'
    click_on('Valider')
    expect(page).to have_content("Liste des catégories")
    expect(page).to have_content("Vacances")
  end

  it 'cancels adding category' do
    visit categories_path
    click_on('Créer une catégorie')
    expect(page).to have_content("Nouvelle catégorie")
    fill_in 'category[name]', with: 'Vacances'
    click_on('Annuler')
    expect(page).to have_content("Liste des catégories")
    expect(page).not_to have_content("Vacances")
  end
end
