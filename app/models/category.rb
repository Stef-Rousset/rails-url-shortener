class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :transactions

  before_validation :capitalize
  before_destroy :update_transactions

  validates :name, presence: true, uniqueness: { scope: :user_id }

  private

  def capitalize
    self.name = name[0].capitalize + name[1..]
  end

  def update_transactions
    Transaction.where(category_id: self.id).update_all(category_id: nil)
  end
end
