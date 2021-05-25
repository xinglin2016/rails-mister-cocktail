class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :destroy]
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
    @dose = Dose.new
    authorize @cocktail
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.user = current_user
    authorize @cocktail

    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
