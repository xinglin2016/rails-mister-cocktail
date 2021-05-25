class Api::V1::CocktailsController < Api::V1::BaseController
  before_action :set_cocktail, only: [ :show ]

  def index
    @cocktails = policy_scope(Cocktail)
  end

  def show
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail  # For Pundit
  end
end
