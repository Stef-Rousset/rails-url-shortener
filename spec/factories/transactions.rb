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
FactoryBot.define do
  factory :transaction do
    factory :transaction1 do
      payee { 'électricité' }
      amount { 49.99 }
      date { '2023-11-29' }
      transaction_type { 0 }
      description { 'novembre 2023' }
      checked { false }
      account { nil }
      category { nil }
    end

    factory :transaction2 do
      payee { 'cinéma' }
      amount { 9.99 }
      date { '2023-12-01' }
      transaction_type { 0 }
      description { '' }
      checked { true }
      account { nil }
      category { nil }
    end
  end
end
