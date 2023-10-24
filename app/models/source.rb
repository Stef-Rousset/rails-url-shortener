class Source < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, :url, presence: true
  validates :name, :url, uniqueness: true
end
