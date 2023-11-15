FactoryBot.define do
  sequence :email do |n|
    "user#{n}@gmail.com"
  end

  factory :user do
    factory :user1 do
      email { generate(:email) }
      password { 'password' }
      spell_count { 5 }
    end
    factory :user2 do
      email { generate(:email) }
      password { 'motdepasse' }
    end
  end
end
