module IngredientsHelper
  include ApplicationHelper
  def add_ingredients_to_database(ingredients)
    ingredients.each do |ingredient|
      ingredient = ingredient.strip.gsub("organic","").downcase
      Food.create(name: ingredient, user_id: current_user.id)
      found_ingredient = Ingredient.find_by(name: ingredient, user_id: current_user.id)
      if found_ingredient
        found_ingredient.pending = true
        found_ingredient.save
      else
        Ingredient.create(name: ingredient, pending: true, user_id: current_user.id)
      end
    end
  end
end
