# frozen_string_literal: true

# Category
class Category < ApplicationRecord
  searchkick

  # Associations
  belongs_to :vertical
  has_many :courses, dependent: :destroy

  # Validations
  validates :name, :state, presence: true
  validate :name_unique_across_categories_and_verticals

  # Callbacks
  after_commit :reindex

  # Nested Attributes
  accepts_nested_attributes_for :courses

  private

  def name_unique_across_categories_and_verticals
    return unless Vertical.where(name: name).exists?

    errors.add(:name, 'must be unique across Categories and Verticals')
  end
end
