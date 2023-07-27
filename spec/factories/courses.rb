FactoryBot.define do
  factory :course do
    associations { :category }
    name { "Scientific Writing" }
    author { "Steven Hawking" }
    state { "Active" }
  end
end
