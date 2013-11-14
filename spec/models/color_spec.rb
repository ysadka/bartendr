require 'spec_helper'

describe Color do
  describe "validations" do
    it {expect(subject).to validate_presence_of(:name)}
    it {expect(subject).to validate_presence_of(:hex_code)}
  end

  describe 'associations' do
    it {expect(subject).to have_many(:ingredients)}
  end
end
