class Color < ActiveRecord::Base
  validates :name, presence: true
  validates :hex_code, presence: true

  has_many :ingredients
end
