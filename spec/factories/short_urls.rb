FactoryBot.define do
  factory :short_url do
    factory :short_url1 do
      long_url { 'https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/' }
      tiny_url { 'wxyZ098' }
      association :user, factory: :user1
    end

    factory :short_url2 do
      long_url { 'https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-rspec' }
      tiny_url { '' }
      association :user, factory: :user2
    end
  end
end
