require 'rails_helper'

RSpec.describe HandleRss, type: :model do
  before(:each) do
    @url = 'https://www.lemonde.fr/rss/une.xml'
  end

  it 'returns an array of 5 hash elements' do
    news = HandleRss.new(@url).get_news
    expect(news.size).to eq(5)
    expect(news[1].class).to eq(Hash)
    expect(news[1].keys).to eq([:title, :description, :link])
  end
end
