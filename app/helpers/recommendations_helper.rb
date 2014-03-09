module RecommendationsHelper
  include ApplicationHelper
# @recipe = {}
#     @recipe.name = recommendation_params[:search]
#     ingredients = get_ingredients_from_yummly(recipe.name)
#     @recipe.ingredients = ingredients.map do |ingredient|
#       name_with_ratings_for(ingredient)
#     end

  def get_recipe_from_yummly(search_term)
    recipes = fetch_recipes(search_term)
    if recipes.empty?
      nil
    else
      recipe = choose_recipe(recipes)
      {name: recipe.name, ingredients: recipe.ingredients }
    end
  end

  def name_with_ratings_for(ingredient_name)
    # { name: ingredient_name, average_rating: 45, ratings: [45,34,56] }

    # get id from ingredients table
    ingredient = Ingredient.find_by(name: ingredient_name)
    if ingredient
      ingredient_id = ingredient.id
      # get ratings from ratings table for that ingred_id
      ratings = Rating.select(:rating).where(ingredient_id: ingredient_id)
      ratings = ratings.map do |rating|
        rating[:rating]
      end
      # calculate average of ratings
      average_rating = ratings.sum / ratings.size
      { name: ingredient_name, average_rating: average_rating, ratings: ratings }
    else
      nil
    end
  end

  def is_ingredient?(search_term)
    Ingredient.where(name: search_term).exists?
  end

end
