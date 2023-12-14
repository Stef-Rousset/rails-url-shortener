FactoryBot.define do
  sequence :email do |n|
    "user#{n}@gmail.com"
  end

  factory :user do
    email { generate(:email) }

    trait :full_spell_count do
      password { 'password' }
      spell_count { 5 }
    end

    trait :normal do
      password { 'motdepasse' }
    end
  end
end
