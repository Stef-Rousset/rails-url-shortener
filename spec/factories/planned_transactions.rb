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
