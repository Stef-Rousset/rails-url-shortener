# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE), not null
#  spell_count            :integer          default(0), not null
#
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
