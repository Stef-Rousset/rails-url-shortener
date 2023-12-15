class PlannedTransaction < ApplicationRecord
  belongs_to :account
  belongs_to :category, optional: true

  enum transaction_type: { debit: 0, credit: 1 }
  enum every: { day: 0, week: 1, month: 2, year: 3 }

  validates :payee, :transaction_type, :every, presence: true
  validates :amount, numericality: { greater_than: 0.0 }

  validate :start_date_greater_than_today

  private

  def start_date_greater_than_today
    unless start_date > Date.today
      # add error on the field start_date
      errors.add(:start_date, :invalid_start_date)
    end
  end
end
