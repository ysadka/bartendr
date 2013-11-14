class IngredientSerializer < ActiveModel::Serializer
  attributes :name, :purchase_url
  has_one :color
end
