# frozen_string_literal: true

# Course
class Course < ApplicationRecord
  searchkick

  # Associations
  belongs_to :category

  # Validations
  validates :name, :author, :state, presence: true

  # Callbacks
  # TODO: Add backgrond job to reindex
  after_commit :reindex

  # TODO: Add enums for state.
  # enum state: { active: 'active', inactive: 'inactive' }
  # I added column as a string as I don't belive that there will be that many objects that we need to use integers because of performance.
  # I added string because of redability when checking the database.
end
