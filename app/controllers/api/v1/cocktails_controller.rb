class Api::V1::CocktailsController < Api::V1::BaseController
  before_action :set_cocktail, only: [ :show, :update ]
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.user = current_user
    authorize @cocktail
    if @cocktail.save
      render :show, status: :created
    else
      render_error
    end
  end

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

  def cocktail_params
    params.require(:cocktail).permit(:name, :description)
  end

  def render_error
    render json: { errors: @cocktail.errors.full_messages },
      status: :unprocessable_entity
  end
end
