# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :planned_transactions

  before_validation :capitalize
  before_destroy :update_transactions_and_planned_transactions

  validates :name, presence: true, uniqueness: { scope: :user_id }

  private

  def capitalize
    self.name = name.strip.capitalize
  end

  def update_transactions_and_planned_transactions
    if Transaction.where(category_id: self.id).present?
      Transaction.where(category_id: self.id).update_all(category_id: nil)
    end
    if PlannedTransaction.where(category_id: self.id).present?
      PlannedTransaction.where(category_id: self.id).update_all(category_id: nil)
    end
  end
end
