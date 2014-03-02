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
      Ingredient.create(name: ingredient, pending: true)
    end
  end




end
