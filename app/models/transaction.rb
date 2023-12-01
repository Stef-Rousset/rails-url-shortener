class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :category, optional: true

  after_save :update_balance_account

  enum transaction_type: { debit: 0, credit: 1 }

  validates :transaction_type, :date, :payee, presence: true

  def previous_transaction
    account.transactions.order(date: :desc, created_at: :desc).where('date > ?', self.date).last
  end

  private

  def update_balance_account
    account = self.account
    balance = account.balance
    if self.transaction_type == 'credit'
      balance += self.amount
    else
      balance -= self.amount
    end
    account.update(balance: balance)
  end
end
