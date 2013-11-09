class Drink < ActiveRecord::Base

  validates :name, presence: true
end
