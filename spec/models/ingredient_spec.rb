require 'spec_helper'

describe Ingredient do
  describe "validations" do
    it {expect(subject).to validate_presence_of(:name)}
    it {expect(subject).to validate_presence_of(:hex_color)}
  end

  describe "associations" do
    it {expect(subject).to have_many(:components)}
    it {expect(subject).to have_many(:drinks).through(:components)}
  end

  describe "#purchase_url" do
    it 'returns the purchase url of the ingredient' do
      ingredient = Ingredient.create(name: 'Cherry Tomatoes')
      expect(ingredient.purchase_url).to eq "https://www.google.com/#q=cherry%20tomatoes&tbm=shop"
    end
  end
end
