class IngredientsController < ApplicationController
  include IngredientsHelper
  before_action :authenticate_user!

  def new
    @ingredient = Ingredient.new()
  end

  def create
    if ingredient_params[:search] == ""
      flash[:alert] = "Please try again with a search term"
      redirect_to new_ingredient_path
      return
    end
    case ingredient_params[:source]
    when "simple"
      chosen_recipe = {}
      chosen_recipe[:name] = ingredient_params[:search]
      chosen_recipe[:ingredients] = [ingredient_params[:search]]
    when "grocery"
      fe_key = ENV["FOOD_ESSENTIALS_KEY"]
      sid = HTTParty.get("http://api.foodessentials.com/createsession?uid=demoUID_01&devid=demoDev_01&appid=demoApp_01&f=json&api_key=#{fe_key}")["session_id"]

      search_term = ingredient_params[:search].gsub(" ","%20")
      results = HTTParty.get("http://api.foodessentials.com/searchprods?q=#{search_term}&sid=#{sid}&n=10&s=0&f=json&api_key=#{fe_key}")
      product = results["productsArray"].first rescue nil
      if product.nil?
        chosen_recipe = nil
      else
        begin
          ingredients = HTTParty.get("http://api.foodessentials.com/label?u=#{product["upc"]}&sid=#{sid}&appid=demoApp_01&f=json&api_key=#{fe_key}")["ingredients"].split(",").map(&:strip).map(&:downcase)
          chosen_recipe = {}
          chosen_recipe[:name] = product["product_name"]
          chosen_recipe[:ingredients] = ingredients
        rescue
          flash[:alert] = "Sorry we couldn't find that food, please try again with a different search term"
          redirect_to new_ingredient_path
          return
        end
      end
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
      params.require(:ingredient).permit(:search, :source)
    end

end
