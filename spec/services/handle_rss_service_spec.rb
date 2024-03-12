require 'rails_helper'

RSpec.describe HandleRss, type: :model do
  before(:each) do
    @url = 'https://www.lemonde.fr/rss/une.xml'
  end

  it 'returns an array of 5 hash elements' do
    news = HandleRss.new(@url).get_news
    expect(news.size).to eq(5)
    expect(news[0].class).to eq(Hash)
    expect(news[0].keys).to eq([:title, :description, :link])
  end
end
