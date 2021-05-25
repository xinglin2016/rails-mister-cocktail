class Api::V1::CocktailsController < Api::V1::BaseController
  before_action :set_cocktail, only: [ :show, :update ]
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]

  def index
    @cocktails = policy_scope(Cocktail)
  end

  def show
  end

  def update
    if @cocktail.update(cocktail_params)
      render :show
    else
      render_error
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail  # For Pundit
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end
end
