# frozen_string_literal: true

# Course
class Course < ApplicationRecord
  searchkick

  # Associations
  belongs_to :category

  # Validations
  validates :name, :author, :state, presence: true

  # Callbacks
  after_commit :reindex

end
