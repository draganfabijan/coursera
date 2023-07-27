# frozen_string_literal: true

# Category
class Category < ApplicationRecord

  # Associations
  belongs_to :vertical
  has_many :courses, dependent: :destroy
end
