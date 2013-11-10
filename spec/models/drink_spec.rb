require 'spec_helper'

describe Drink do
  describe "validations" do
    it {expect(subject).to validate_presence_of(:name)}
  end

  describe "associations" do
    it {expect(subject).to have_many(:components)}
    it {expect(subject).to have_many(:ingredients).through(:components)}
    it {expect(subject).to belong_to(:glass)}
  end
end
