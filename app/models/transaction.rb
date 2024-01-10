# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  payee            :string           not null
#  amount           :decimal(11, 2)   default(0.0)
#  date             :date             not null
#  transaction_type :integer          not null
#  description      :text
#  checked          :boolean          default(FALSE)
#  account_id       :bigint           not null
#  category_id      :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :category, optional: true

  after_create :update_balance_account
  after_update :update_balance_if_changes_on_amount_or_type

  enum transaction_type: { debit: 0, credit: 1 }
  scope :ordered, -> { order(date: :desc, created_at: :desc) }

  validates :transaction_type, :date, :payee, presence: true
  validates :amount, numericality: { greater_than: 0.0 }

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

  def update_balance_if_changes_on_amount_or_type
    account = self.account
    balance = account.balance
    if self.saved_change_to_amount?
      old_amount, new_amount = self.saved_change_to_amount
      if self.saved_change_to_transaction_type?
        # amount and type have changed
        new_type = self.saved_change_to_transaction_type[1]
        if new_type == 'credit'
          balance += (old_amount + new_amount)
        else
          balance -= (old_amount + new_amount)
        end
      else
        # only amount has changed
        if self.transaction_type == 'credit'
          balance += (new_amount - old_amount)
        else
          balance -= (new_amount - old_amount)
        end
      end
    elsif self.saved_change_to_transaction_type?
      # only type has changed
      new_type = self.saved_change_to_transaction_type[1]
      if new_type == 'credit'
        balance += self.amount * 2
      else
        balance -= self.amount * 2
      end
    end
    account.update(balance: balance)
  end
end
