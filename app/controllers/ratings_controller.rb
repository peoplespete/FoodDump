class RatingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @rating = Rating.new
  end

  def create
    rating = rating_params[:scale].to_i
    Dump.create(rating: rating)

    @ingredients = Ingredient.where(pending: true, user_id: current_user.id)

    @ingredients.each do |ingredient|
      Rating.create(rating: rating, ingredient_id: ingredient.id, user_id: current_user.id)
      ingredient.pending = false
      ingredient.save
    end

    flash[:success] = "Rating of #{rating} Added!"

    redirect_to root_url
  end


  private

    def rating_params
      params.require(:rating).permit(:scale)
    end

end
