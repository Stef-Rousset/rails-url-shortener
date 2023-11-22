require 'rails_helper'
require 'debug'

RSpec.describe 'ShortUrls', type: :system do
  before(:each) do
    @user = create(:user1)
    @short_url = create(:short_url1, user: @user)
    @long_url = @short_url.long_url
    sign_in @user
  end

  it 'deletes url when clicking on trash icon' do
    visit short_urls_path
    expect(page).to have_content('Mes urls courtes créees')
    expect(page).to have_content(@long_url)
    find('.fa-trash-can').click
    expect(page).not_to have_content(@long_url)
  end

  it 'creates a new url' do
    visit short_urls_path
    expect(page).to have_content('Mes urls courtes créees')
    click_on('Créer une nouvelle url courte')
    expect(page).to have_content('Créer une nouvelle url courte')
    fill_in 'short_url[long_url]', with: 'https://www.ffescrime.fr/je-suis-en-club/arbitres/commission-nationale/'
    click_on('Créer')
    expect(page).to have_content('Votre url courte pour:')
    expect(page).to have_content('https://www.ffescrime.fr/je-suis-en-club/arbitres/commission-nationale/')
  end
end
