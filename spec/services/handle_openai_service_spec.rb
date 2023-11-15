require 'rails_helper'

RSpec.describe HandleOpenai, type: :model do
  before(:each) do
    @word = 'bouteile'
  end

  it 'returns a string containing the correct word' do
    response = HandleOpenai.new(@word).get_word_checked
    expect(response.class).to eq String
    expect(response).to include('bouteille')
  end
end

