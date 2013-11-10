class Component < ActiveRecord::Base
  belongs_to :drink
  belongs_to :ingredient

  def quantity_in_ounces
    quantity / 100.to_f
  end
end
