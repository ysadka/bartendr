class Component < ActiveRecord::Base
  belongs_to :drink
  belongs_to :ingredient

  def quantity_to_ounces
    quantity / 100.to_f
  end
end
