class ShortUrl < ApplicationRecord
  belongs_to :user

  validates :long_url, :tiny_url, presence: true
  validates :tiny_url, length: { is: 7 }, uniqueness: true

  before_validation :add_tiny_url, on: :create
  before_create :sanitize_long_url

  def self.existing_tiny_url?(url)
    ShortUrl.where(tiny_url: url).present?
  end

  def self.generate_tiny_url
    # generate a random base62 (cad 0-9 , a-z , A-Z) string of 7 characters
    array = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a
    array.sample(7).join('')
  end
  # define class methods as private
  #class << self
  #  private :existing_tiny_url?
  #end

  private

  def sanitize_long_url
    long_url.strip!
  end

  def add_tiny_url
    tiny_url = ShortUrl.generate_tiny_url
    while ShortUrl.existing_tiny_url?(tiny_url)
      tiny_url = ShortUrl.generate_tiny_url
    end
    self.tiny_url = tiny_url
  end
end
