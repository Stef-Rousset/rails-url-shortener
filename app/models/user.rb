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

  has_many :short_urls
  has_and_belongs_to_many :sources

  def user_news
    hash = sources.map { |source| [source.name, HandleRss.new(source.url).get_news] }.to_h
    if hash.keys.include?('lequipe')
      hash.each do |key, value|
        value.map { |item| item[:description] = item[:description].gsub!(/<.*>/, '') } if key == 'lequipe'
      end
    end
    hash
  end

  private

  def email_normalization
    self.email = email.downcase
  end
end
