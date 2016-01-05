module IngredientsHelper
  include ApplicationHelper

  def add_ingredients_to_database(ingredients)
    ingredients.each do |ingredient|
      ingredient = ingredient.strip.gsub("organic","")
      puts "adding #{ingredient} to DB..."
      found_ingredient = Ingredient.find_by(name: ingredient, user_id: current_user.id)
      # ADD HERE TO A NEW MODEL FOOD
      if found_ingredient
      # look for ingredient...if it exists just change pending to true
        found_ingredient.pending = true
        found_ingredient.save
      else
      # otherwise create it
        Ingredient.create(name: ingredient, pending: true, user_id: current_user.id)
      end
    end
  end

end
