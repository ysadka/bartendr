class DrinksController < ApplicationController

  def index
  end

  def show
    @drink = Drink.where(name: params[:name].capitalize).includes(:components, :ingredients).first

    if @drink.nil?
      render json: {errors: 'Drink not found'}, status: :unprocessable_entity
    else
      render json: @drink, root: false
    end
  end
end
