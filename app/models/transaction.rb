class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :category, optional: true

  enum transaction_type: { debit: 0, credit: 1 }

  validates :transaction_type, :date, :payee, presence: true
end
