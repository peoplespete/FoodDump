FactoryGirl.define do
  factory :ingredient do
    sequence(:name)  { |n| "Ingredient #{n}" }
    sequence(:pending) { |n| [ false, true ][n%2] }
  end

  factory :rating do
    sequence(:rating) { rand(0..100) }
    ingredient
  end
end