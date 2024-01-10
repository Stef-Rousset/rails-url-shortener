# frozen_string_literal: true

# == Schema Information
#
# Table name: planned_transactions
#
#  id               :bigint           not null, primary key
#  payee            :string           not null
#  amount           :decimal(11, 2)   default(0.0)
#  start_date       :date             not null
#  description      :text
#  transaction_type :integer          not null
#  every            :integer          not null
#  account_id       :bigint           not null
#  category_id      :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
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
