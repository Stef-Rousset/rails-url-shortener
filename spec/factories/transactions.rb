FactoryBot.define do
  factory :transaction do
    payee { "MyString" }
    amount { 9.99 }
    date { "2023-11-29" }
    type { 1 }
    description { "MyText" }
    checked { false }
    account { nil }
    categorie { nil }
  end
end
