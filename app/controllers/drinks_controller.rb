class DrinksController < ApplicationController

  def index
  end

  def show
    @drink = Drink.where(name: params[:name]).includes(:components, :ingredients).first

    render json: @drink, root: false
  end
end
