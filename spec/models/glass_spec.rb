require 'spec_helper'

describe Glass do
  describe "validations" do
    it {expect(subject).to validate_presence_of(:name)}
    it {expect(subject).to validate_presence_of(:img_url)}
  end

  describe "associations" do
    it {expect(subject).to have_many(:drinks)}
  end

  describe "#purchase_url" do
    it 'returns the purchase url of the glass' do
      ingredient = build(:glass, name: 'Martini')
      expect(ingredient.purchase_url).to eq "https://www.google.com/#q=martini+glass&tbm=shop"
    end
  end
end
