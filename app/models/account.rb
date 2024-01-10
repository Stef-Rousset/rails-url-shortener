# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  balance    :decimal(11, 2)   default(0.0)
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
