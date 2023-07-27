# frozen_string_literal: true

# Category
class Category < ApplicationRecord

  # Associations
  belongs_to :vertical
  have_many :courses
end
