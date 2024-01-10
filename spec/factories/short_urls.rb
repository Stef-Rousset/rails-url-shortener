# == Schema Information
#
# Table name: short_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  tiny_url   :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :short_url do

    trait :with_tiny_url do
      long_url { 'https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/' }
      tiny_url { 'wxyZ098' }
    end

    trait :without_tiny_url do
      long_url { 'https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-rspec' }
      tiny_url { '' }
    end
  end
end
