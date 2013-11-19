class DrinksController < ApplicationController
  before_filter :flag_tipjar

  def index
  end

  def show
    @drink = Drink.where('name like ?', "%#{params[:name].downcase}%").includes(:components, :ingredients).sample

    if @drink.nil?
      render json: {errors: 'Drink not found'}, status: :unprocessable_entity
    else
      render json: @drink, root: false
    end
  end

  private

  def flag_tipjar
    @tipjar = $rollout.active?(:payments)
  end
end
