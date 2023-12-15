FactoryBot.define do
  factory :planned_transaction do
    payee { "Impots" }
    amount { "50.0" }
    start_date { "2023-12-15" }
    description { "taxe" }
    transaction_type { 0 }
    account { nil }
    category { nil }
    every { 2 }
  end
end
