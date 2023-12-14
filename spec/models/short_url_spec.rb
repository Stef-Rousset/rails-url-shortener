require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  before(:each) do
    @user = create(:user, :normal)
  end

  it 'is invalid without long_url' do
    one = ShortUrl.new(long_url: '', tiny_url: '', user_id: @user.id)
    expect(one).to_not be_valid
  end

  it 'is valid with long_url' do
    one = ShortUrl.new(long_url: 'https://www.ffescrime.fr/je-suis-en-club/competiteurs/reglements/', tiny_url: '', user_id: @user.id)
    expect(one).to be_valid
  end

  it 'should have a tiny_url with length 7' do
    one = ShortUrl.create(long_url: 'https://www.ffescrime.fr/je-suis-en-club/competiteurs/reglements/', tiny_url: "", user_id: @user.id)
    expect(one).to be_valid
    expect(one.tiny_url.length).to eq(7)
  end

  it 'should check if tiny_url is present or not' do
    one = ShortUrl.create(long_url: 'https://www.ffescrime.fr/je-suis-en-club/competiteurs/reglements/', tiny_url: "", user_id: @user.id)
    presence = ShortUrl.existing_tiny_url?(one.tiny_url)
    absence = ShortUrl.existing_tiny_url?("xxxxxxx")
    expect(presence).to eq true
    expect(absence).to eq false
  end

  it 'should generate a random string of 7 characters' do
    string = ShortUrl.generate_tiny_url
    expect(string.class).to eq String
    expect(string.length).to eq 7
  end

  it 'should eleminate spaces at begining or end of long_url before create' do
    one = ShortUrl.create(long_url: " https://www.ffescrime.fr/je-suis-en-club/competiteurs/ ", tiny_url: "", user_id: @user.id)
    expect(one.long_url).to eq "https://www.ffescrime.fr/je-suis-en-club/competiteurs/"
  end
end
