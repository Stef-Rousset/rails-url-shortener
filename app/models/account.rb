class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  before_validation :capitalize

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :balance, numericality: true

  private

  def capitalize
    self.name = name[0].capitalize + name[1..]
  end
end
