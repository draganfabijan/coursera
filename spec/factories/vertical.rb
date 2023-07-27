FactoryBot.define do
  factory :vertical do
    sequence(:name) { |n| "Health & Fitness #{n}" }
  end
end
