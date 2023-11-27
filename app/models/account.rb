class Account < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :balance, numericality: true
end
