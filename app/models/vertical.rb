# frozen_string_literal: true

# Vertical
class Vertical < ApplicationRecord
  searchkick

  # Associations
  has_many :categories, dependent: :destroy

  # Validations
  validates :name, presence: true
  validate :name_unique_across_categories_and_verticals

  # Callbacks
  after_commit :reindex

  # Nested Attributes
  accepts_nested_attributes_for :categories

  private

  def name_unique_across_categories_and_verticals
    if Category.where(name: name).exists?
      errors.add(:name, "must be unique across Categories and Verticals")
    end
  end
end
