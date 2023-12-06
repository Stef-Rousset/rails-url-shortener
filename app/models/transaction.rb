class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :category, optional: true

  after_create :update_balance_account
  after_update :update_balance_if_amount_changes

  enum transaction_type: { debit: 0, credit: 1 }
  scope :ordered, -> { order(date: :desc, created_at: :desc) }

  validates :transaction_type, :date, :payee, presence: true

  def previous_transaction
    account.transactions.ordered.where('date > ?', self.date).last
  end

  def update_balance_after_destroy
    account = self.account
    balance = account.balance
    if self.transaction_type == 'credit'
      balance -= self.amount
    else
      balance += self.amount
    end
    account.update(balance: balance)
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

  def update_balance_if_amount_changes
    if self.saved_change_to_amount?
      old_amount, new_amount = self.saved_change_to_amount
      account = self.account
      balance = account.balance
      if self.transaction_type == 'credit'
        balance += (new_amount - old_amount)
      else
        balance -= (new_amount - old_amount)
      end
      account.update(balance: balance)
    end
  end
end
