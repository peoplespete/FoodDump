class IngredientsController < ApplicationController
  include IngredientsHelper

  def new
    @ingredient = Ingredient.new
  end

  def create
    if ingredient_params[:search] == ""
      flash[:alert] = "Please try again with a search term"
      redirect_to new_ingredient_path
      return
    end
    is_ingredient = ingredient_params[:is_ingredient].to_i == 1 ? true : false
    if is_ingredient
      chosen_recipe = {}
      chosen_recipe[:name] = ingredient_params[:search]
      chosen_recipe[:ingredients] = [ingredient_params[:search]]
    else
      recipes = fetch_recipes(ingredient_params[:search])
      yummly_recipe = choose_recipe(recipes)
      if yummly_recipe
        chosen_recipe = {}
        chosen_recipe[:name] = yummly_recipe.name
        chosen_recipe[:ingredients] = yummly_recipe.ingredients
      end
    end
    if chosen_recipe
      add_ingredients_to_database(chosen_recipe[:ingredients])
      flash[:success] = "#{chosen_recipe[:name]} Added!"
    else
      flash[:alert] = "Sorry we couldn't find that food, please try again with a different search term"
      redirect_to new_ingredient_path
      return
    end
      redirect_to root_url
  end


  private

    def ingredient_params
      params.require(:ingredient).permit(:search, :is_ingredient)
    end

end
