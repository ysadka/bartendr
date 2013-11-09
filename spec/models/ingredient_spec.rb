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
end
