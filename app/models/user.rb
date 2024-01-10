# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#  id                     :bigint          not null, primary key
#  email                  :string          default: "", not null
#  encrypted_password     :string          default: "", not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  admin                 :boolean          default: false, not null

# Indexes
#  index_users_on_email                 (email)                 unique
#  index_users_on_reset_password_token  (reset_password_token)  unique
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :email_normalization
  after_create :create_categories

  has_many :short_urls, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_and_belongs_to_many :sources

  def user_news
    hash = sources.map { |source| [source.name, HandleRss.new(source.url).get_news] }.to_h
    # remove the <img> present in description when source is lequipe
    if hash.keys.include?('lequipe')
      hash['lequipe'].each do |item|
        item[:description] = item[:description].gsub!(/<.*>/, '')
      end
    end
    hash
  end

  def accounts_total_sum
    accounts.map(&:balance).sum
  end

  private

  def email_normalization
    self.email = email.downcase
  end

  def create_categories
    # after creating a user, create its categories
    %w[Salaire Alimentation Impots Santé Loisirs Transports Habillement Loyer Charges].each do |category|
      Category.create!(name: category, user_id: self.id)
    end
  end
end
