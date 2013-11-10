class DrinkSerializer < ActiveModel::Serializer
  attributes :name
  has_many :components
  has_one :glass
end
