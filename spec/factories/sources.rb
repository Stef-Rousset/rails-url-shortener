FactoryBot.define do
  factory :source do
    factory :source_one do
      name { "lemonde" }
      url { "https://www.lemonde.fr/rss/une.xml" }
    end
  end
end
