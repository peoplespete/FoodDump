module IngredientsHelper

  def fetch_recipes
    search_term = ingredient_params[:search]
    Yummly.search(search_term).map { |recipe| recipe }
  end

  def choose_recipe(recipes)
    recipes[0]
  end

  def add_ingredients_to_database(ingredients)
    ingredients.each do |ingredient|
      found_ingredient = Ingredient.find_by(name: ingredient)
      if found_ingredient
      # look for ingredient...if it exists just change pending to true
        found_ingredient.pending = true
        found_ingredient.save
      else
      # otherwise create it
        Ingredient.create(name: ingredient, pending: true)
      end
    end
  end




end
