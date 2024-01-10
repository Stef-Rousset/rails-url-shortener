# frozen_string_literal: true

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
class Source < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, :url, presence: true
  validates :name, :url, uniqueness: true
end
