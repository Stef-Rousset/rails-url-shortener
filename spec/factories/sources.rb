# == Schema Information
#
# Table name: sources
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :source do
    factory :source_one do
      name { "lemonde" }
      url { "https://www.lemonde.fr/rss/une.xml" }
    end
  end
end
