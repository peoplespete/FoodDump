class RecommendationsController < ApplicationController
  include RecommendationsHelper

  def new
    @recommendation = "Recommendation"
  end

  def create
    redirect_to recommendations_path(params)
  end

  def index
    search_term = recommendation_params[:search]
    # search through the ingredients table first and make sure to allow the one rating to get through the if below
    # and capitalize it too

    if is_ingredient?(search_term)
      ingredient = Ingredient.find_by(name: search_term)
      chosen_recipe = {name: ingredient[:name].capitalize, ingredients: [ ingredient[:name] ]}
    else
      chosen_recipe = get_recipe_from_yummly(search_term)
      unless chosen_recipe
        flash[:error] = "Sorry we couldn't find that food, please try again with a different search term"
        redirect_to new_recommendation_path
        return
      end
    end

    @recipe = {}
    @recipe[:name] = chosen_recipe[:name]
    @recipe[:ingredients] = chosen_recipe[:ingredients].map do |ingredient|
      name_with_ratings_for(ingredient)
    end
    @recipe[:ingredients].compact!

    averages = @recipe[:ingredients].map do |ingredient|
      # here is where we can add the std dev logic
      ingredient[:average_rating]
    end
    if averages.size < 2 and !is_ingredient?(search_term)
      flash[:error] = "Sorry we couldn't find enough information to accurately predict that food's effect on you.  Please try again with a different food."
      redirect_to new_recommendation_path
    else
      @recipe[:average_rating] = averages.sum / averages.size
    end
  end

  private

    def recommendation_params
      params.permit(:search)
    end

end
