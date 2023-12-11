FactoryBot.define do
  factory :transaction do
    factory :transaction1 do
      payee { "électricité" }
      amount { 49.99 }
      date { "2023-11-29" }
      transaction_type { 0 }
      description { "novembre 2023" }
      checked { false }
      account { nil }
      category { nil }
    end

    factory :transaction2 do
      payee { "cinéma" }
      amount { 9.99 }
      date { "2023-12-01" }
      transaction_type { 0 }
      description { "" }
      checked { false }
      account { nil }
      category { nil }
    end
  end
end
