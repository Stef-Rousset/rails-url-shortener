require 'open-uri'
require 'rss'
# Service to handle recuperation of news via rss
class HandleRss
  def initialize(url)
    @url = url
  end

  def get_news
    array = []
    URI.open(@url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.first(5).each do |item|
        array << {title: item.title, description: item.description, link: item.link}
      end
    end
    array
  end
end
