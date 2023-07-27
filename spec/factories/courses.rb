FactoryBot.define do
  factory :course do
    association :category
    name { 'Scientific Writing' }
    author { 'Steven Hawking' }
    state { 'active' }
  end
end
