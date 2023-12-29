FactoryBot.define do
  factory :category do
    factory :category1 do
      name { 'Salaire' }
      user { nil }
    end

    factory :category2 do
      name { 'Alimentation' }
      user { nil }
    end
  end
end
