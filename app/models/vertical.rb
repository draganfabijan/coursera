# Vertical
class Vertical < ApplicationRecord
  searchkick
  # TODO: Create new file for ES purposes, with search_data method to index only columns that are needed
  # for example remove created_at and updated_at

  # Associations
  has_many :categories, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :name, uniqueness: true
  validate :name_unique_across_categories_and_verticals

  # Callbacks
  # TODO: Add background job to reindex
  after_commit :reindex

  # Nested Attributes
  accepts_nested_attributes_for :categories

  # TODO: Add enums for state.
  # enum state: { active: 'active', inactive: 'inactive' }
  # I added column as a string as I don't belive that there will be that many objects that we need to use integers because of performance.
  # I added string because of readability when checking the database.

  private

  def name_unique_across_categories_and_verticals
    return unless Category.where(name: name).exists?

    errors.add(:name, 'must be unique across Categories and Verticals')
  end
end
