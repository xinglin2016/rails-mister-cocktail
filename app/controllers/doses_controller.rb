class DosesController < ApplicationController
  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.find(params[:id])
    @dose.cocktail = @dose
    if @dose.save
      redirect_to cocktail_path(@dose)
    else
      render :new
    end
  end

  def destroy
    @dose.destroy
    redirect_to doses_path
  end
end
