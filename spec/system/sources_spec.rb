require 'rails_helper'
require 'debug'

RSpec.describe 'Sources', type: :system do
  before(:each) do
    @user = create(:user1)
    @source = create(:source_one)
    sign_in @user
  end

  it 'adds source to user and redirects to index' do
    visit choose_sources_path
    expect(page).to have_content("Les sources d'information disponibles")
    find('#lemonde').click
    click_on('Valider')
    expect(page).to have_content("Mes sources d'information")
    expect(page).to have_content("Le Monde")
  end

  it 'cancels adding source to user' do
    visit choose_sources_path
    expect(page).to have_content("Les sources d'information disponibles")
    find('#lemonde').click
    click_on('Annuler')
    expect(page).to have_content("Les sources d'information disponibles")
  end

  it 'modifies source for user' do
    @user.sources << @source
    visit sources_path
    expect(page).to have_content("Mes sources d'information")
    expect(page).to have_content("Le Monde")
    click_on('Modifier les sources')
    find('#lemonde').click
    click_on('Valider')
    expect(page).to have_content("Les sources d'information disponibles")
  end

  it 'cancels the modification of source for user' do
    @user.sources << @source
    visit sources_path
    expect(page).to have_content("Mes sources d'information")
    expect(page).to have_content("Le Monde")
    click_on('Modifier les sources')
    find('#lemonde').click
    click_on('Annuler')
    expect(page).to have_content("Mes sources d'information")
    expect(page).to have_content("Le Monde")
  end
end
