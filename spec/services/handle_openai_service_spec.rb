require 'rails_helper'

RSpec.describe HandleOpenai, type: :model do

  it 'returns a string containing the correct word in french' do
    response = HandleOpenai.new('bouteile', 'fr', 'fr').get_word_checked
    expect(response.class).to eq String
    expect(response).to include('bouteille')
  end

  it 'returns a string containing the correct word in english' do
    response = HandleOpenai.new('botle', 'en', 'en').get_word_checked
    expect(response.class).to eq String
    expect(response).to include('bottle')
  end
end

