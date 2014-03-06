class IngredientsController < ApplicationController
  include IngredientsHelper

  def new
    @ingredient = Ingredient.new
  end

  def create
    # go to yummly!
    recipes = fetch_recipes(ingredient_params[:search])
    chosen_recipe = choose_recipe(recipes)
    if chosen_recipe
      add_ingredients_to_database(chosen_recipe.ingredients)
      flash[:success] = "#{chosen_recipe.name} Added!"
    else
      flash[:error] = "Sorry we couldn't find that food, please try again with a different search term"
    end
      redirect_to root_url
  end


  private

    def ingredient_params
      params.require(:ingredient).permit(:search)
    end

end
