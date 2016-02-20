class InterventionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @code_options = Intervention.pluck(:code).sort
    @intervention = Intervention.new()
  end

  def create
    Intervention.create base_params
    redirect_to root_url

  end

  protected

  def base_params
    params.require(:intervention).permit(:code)
  end

end
