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
FactoryBot.define do
  factory :planned_transaction do
    payee { "Impots" }
    amount { "50.0" }
    start_date { Date.today + 1.day }
    description { "taxe" }
    transaction_type { 0 }
    account { nil }
    category { nil }

    trait :every_day do
      every { 0 }
    end

    trait :every_week do
      every { 1 }
    end

    trait :every_month do
      every { 2 }
    end

    trait :every_year do
      every { 3 }
    end
  end
end
