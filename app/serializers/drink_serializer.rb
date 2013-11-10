class DrinkSerializer < ActiveModel::Serializer
  attributes :name, :preparation
  has_many :components
  has_one :glass
end
