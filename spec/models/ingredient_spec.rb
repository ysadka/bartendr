require 'spec_helper'

describe Ingredient, "validations" do
  it {expect(subject).to validate_presence_of(:name)}
  it {expect(subject).to validate_presence_of(:hex_color)}
end
