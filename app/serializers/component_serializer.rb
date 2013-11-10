class ComponentSerializer < ActiveModel::Serializer
  attributes :quantity_in_ounces
  has_one :ingredient
end
