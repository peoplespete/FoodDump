class RatingsController < ApplicationController

  def new
    @rating = Rating.new
  end

  def create
    # go ahead and make the rating for all pending ingredients
    rating = rating_params[:scale].to_i
    if rating.to_s == rating_params[:scale]
      # this verifies that the rating was really a number (ruby converts 'r'.to_i to 0)
      @ingredients = Ingredient.where(pending: true)

      @ingredients.each do |ingredient|
        Rating.create(rating: rating, ingredient_id: ingredient.id)
        ingredient.pending = false
        ingredient.save
      end

      flash[:success] = "Rating of #{rating} Added!"
    else
      flash[:error] = "Sorry we couldn't add that rating, please try again with a different rating"
    end

    redirect_to root_url
  end


  private

    def rating_params
      params.require(:rating).permit(:scale)
    end

end
