class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  has_many :planned_transactions, dependent: :destroy

  before_validation :capitalize

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :balance, numericality: true

  private

  def capitalize
    self.name = name.strip.capitalize
  end
end
