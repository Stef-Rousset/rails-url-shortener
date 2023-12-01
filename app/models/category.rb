class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :transactions

  before_validation :capitalize

  validates :name, presence: true, uniqueness: { scope: :user_id }

  private

  def capitalize
    self.name = name[0].capitalize + name[1..]
  end
end
