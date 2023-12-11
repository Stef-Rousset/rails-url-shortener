FactoryBot.define do
  factory :account do
    name { "Bank account" }
    balance { "9.99" }
    user { nil }
  end
end
