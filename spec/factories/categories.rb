FactoryBot.define do
  factory :category do
    association :vertical
    sequence(:name) { |n| "Music #{n}" }
    state { 'active' }
  end
end
