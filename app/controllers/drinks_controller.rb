class DrinksController < ApplicationController

  def index
  end

  def show
    @drink = Drink.where('name like ?', "%#{params[:name].downcase}%").includes(:components, :ingredients).first

    if @drink.nil?
      render json: {errors: 'Drink not found'}, status: :unprocessable_entity
    else
      render json: @drink, root: false
    end
  end
end
