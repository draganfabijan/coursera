FactoryBot.define do
  factory :category do
    associations { :vertical }
    name { "Music" }
    state { "Active" }
  end
end
