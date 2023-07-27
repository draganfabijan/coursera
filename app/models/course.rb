# frozen_string_literal: true

# Course
class Course < ApplicationRecord

  # Associations
  belongs_to :category
end
