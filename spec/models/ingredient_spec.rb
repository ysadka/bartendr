require 'spec_helper'

describe Ingredient do
  describe "validations" do
    it {expect(subject).to validate_presence_of(:name)}
  end

  describe "associations" do
    it {expect(subject).to have_many(:components)}
    it {expect(subject).to have_many(:drinks).through(:components)}
    it {expect(subject).to belong_to(:color)}
  end

  describe "#purchase_url" do
    it 'returns the purchase url of the ingredient' do
      ingredient = build(:ingredient, name: 'Cherry Tomatoes')
      expect(ingredient.purchase_url).to eq "https://www.google.com/#q=cherry+tomatoes&tbm=shop"
    end
  end
end
