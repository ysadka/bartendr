require 'spec_helper'

describe Drink, "validations" do
  it {expect(subject).to validate_presence_of(:name)}
end
