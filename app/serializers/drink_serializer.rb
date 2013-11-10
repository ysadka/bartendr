class DrinkSerializer < ActiveModel::Serializer
  attributes :name
  has_many :components
end
