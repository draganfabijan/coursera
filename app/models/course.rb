# Course
class Course < ApplicationRecord
  searchkick
  # TODO: Create new file for ES purposes, with search_data method to index only columns that are needed
  # for example remove created_at and updated_at

  # Associations
  belongs_to :category

  # Validations
  validates :name, :author, :state, presence: true

  # Callbacks
  # TODO: Add background job to reindex
  after_commit :reindex

  # TODO: Add enums for state.
  # enum state: { active: 'active', inactive: 'inactive' }
  # I added column as a string as I don't belive that there will be that many objects that we need to use integers because of performance.
  # I added string because of redability when checking the database.
end
