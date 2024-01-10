# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  balance    :decimal(11, 2)   default(0.0)
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :account do
    name { "Bank account" }
    balance { "9.99" }
    user { nil }
  end
end
