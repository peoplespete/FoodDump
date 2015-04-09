class RecommendationsController < ApplicationController
  include RecommendationsHelper
  before_action :authenticate_user!

  def new
    @recommendation = "Recommendation"
  end

  def create
    redirect_to recommendations_path(params)
  end

  def index
    if recommendation_params[:search] == ""
      flash[:alert] = "Please try again with a search term"
      redirect_to new_recommendation_path
      return
    end
    search_term = recommendation_params[:search]
    if is_ingredient?(search_term)
      ingredient = Ingredient.find_by(name: search_term, user_id: current_user.id)
      chosen_recipe = {name: ingredient[:name], ingredients: [ ingredient[:name] ]}
    else
      chosen_recipe = get_recipe_from_yummly(search_term)
      unless chosen_recipe
        flash[:alert] = "Sorry we couldn't find that food, please try again with a different search term"
        redirect_to new_recommendation_path
        return
      end
    end

    @recipe = {}
    @recipe[:name] = chosen_recipe[:name]
    @recipe[:ingredients] = chosen_recipe[:ingredients].map do |ingredient|
      name_with_ratings_for(ingredient) rescue nil
    end
    @recipe[:ingredients].compact!

    averages = @recipe[:ingredients].map do |ingredient|
      valid_average = ingredient[:ratings].size > 1 && ingredient[:ratings].stdev < 20
      ingredient[:average_rating] if valid_average
    end
    averages.compact!
    if averages.empty?
      flash[:alert] = "Sorry we couldn't find enough information to accurately predict that food's effect on you.  Please try again with a different food."
      redirect_to new_recommendation_path
    else
      @recipe[:average_rating] = averages.sum / averages.size
      @recipe[:adjusted_rating]  = 2 * (50 - ( 50 - @recipe[:average_rating] ).abs)
    end
  end

  private

    def recommendation_params
      params.permit(:search)
    end

end
