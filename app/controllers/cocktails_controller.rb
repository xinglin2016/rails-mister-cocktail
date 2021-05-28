class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :update, :edit]
  skip_before_action :authenticate_user!

  def index
    @cocktails = Cocktail.all
    if params[:query].present?
      @cocktails = policy_scope(Cocktail).search_by_title_and_category_and_console(params[:query])
    else
      @cocktails = policy_scope(Cocktail)
    end
  end

  def show
    @doses = @cocktail.doses
    @dose = Dose.new
  end

  def edit
  end

  def update
    @cocktail.update(cocktail_params)

    if @cocktail.save
      redirect_to @cocktail
    else
      render :edit
    end
  end

  def new
    @cocktail = current_user.cocktails.new
    authorize @cocktail
  end

  def create
    @cocktail = current_user.cocktails.new(cocktail_params)

    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
    authorize @cocktail
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :description, :user_id)
  end
end
