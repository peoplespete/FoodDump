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

    chosen_recipe = get_recipe_from_yummly(search_term)
    @recipe = {}
    @recipe[:name] = chosen_recipe.name
    @recipe[:ingredients] = chosen_recipe.ingredients.map do |ingredient|
      name_with_ratings_for(ingredient)
    end
    @recipe[:ingredients].compact!

    averages = @recipe[:ingredients].map do |ingredient|
      ingredient[:average_rating]
    end

    @recipe[:average_rating] = averages.sum / @recipe[:ingredients].size
  end

  private

    def recommendation_params
      params.permit(:search)
    end

end
