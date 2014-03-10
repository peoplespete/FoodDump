namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Ingredient.delete_all
    Rating.delete_all
    200.times do |n|
      make_ingredient(n+1)
      make_ratings(n+1)
    end
  end
end

def make_ingredient(n)
  ingredient = Ingredient.create!(name: "Example Ingredient #{n}", pending: true)
end

def make_ratings(n)
  ingredient = Ingredient.find(n)
  ingredient.ratings.create!(rating: 4)
  ingredient.ratings.create!(rating: 5)
  ingredient.ratings.create!(rating: 42)
  ingredient.ratings.create!(rating: 34)
  # users = Ingredient.all(limit: 6)
  # 50.times do
  #   content = Faker::Lorem.sentence(5)
  #   users.each { |user| user.microposts.create!(content: content) }
  # end
end
