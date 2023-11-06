# frozen_string_literal: true

# == Schema Information
#
# Table name: sources
#  id                    :bigint           not null, primary key
#  name                  :string           null: false
#  url                   :string           null: false

# Indexes
#  index_sources_on_name    (name)         unique: true
#  index_sources_on_url     (url)          unique: true
class Source < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, :url, presence: true
  validates :name, :url, uniqueness: true
end
