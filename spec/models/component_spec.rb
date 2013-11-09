require 'spec_helper'

describe Component do
  describe "associations" do
    it {expect(subject).to belong_to(:drink)}
    it {expect(subject).to belong_to(:ingredient)}
  end

  describe "#quantity_to_ounces" do
    it 'returns the quantity in ounces' do
      component = Component.create(drink_id: 1, ingredient_id: 1, quantity: 350)
      expect(component.quantity_to_ounces).to eq 3.5
    end
  end
end
