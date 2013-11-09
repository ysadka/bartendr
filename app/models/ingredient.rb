class Ingredient < ActiveRecord::Base

  validates :name, presence: true
  validates :hex_color, presence: true
end
