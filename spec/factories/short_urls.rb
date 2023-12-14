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
