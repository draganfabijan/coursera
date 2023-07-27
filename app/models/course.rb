# frozen_string_literal: true

# Course
class Course < ApplicationRecord

  # Associations
  belongs_to :category

  # Validations
  validates :name, :author, :state, presence: true
end
