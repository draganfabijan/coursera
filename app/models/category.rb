# frozen_string_literal: true

# Category
class Category < ApplicationRecord

  # Associations
  belongs_to :vertical
  has_many :courses, dependent: :destroy

  # Validations
  validates :name, :state, presence: true
  validate :name_unique_across_categories_and_verticals

  private

  def name_unique_across_categories_and_verticals
    if Vertical.where(name: name).exists?
      errors.add(:name, "must be unique across Categories and Verticals")
    end
  end
end
