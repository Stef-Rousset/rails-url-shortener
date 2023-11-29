class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  before_save :capitalize

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :balance, numericality: true

  private

  def capitalize
    self.name = self.name[0].capitalize + self.name[1..-1]
  end
end
