class Drink < ActiveRecord::Base
  validates :name, presence: true

  has_many :components
  has_many :ingredients, through: :components

  belongs_to :glass
  belongs_to :prep_type
end
