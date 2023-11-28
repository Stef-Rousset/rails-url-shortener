class Category < ApplicationRecord
  belongs_to :user, optional: true

  before_create :capitalize

  validates :name, presence: true

  private

  def capitalize
    self.name = self.name.capitalize
  end
end
