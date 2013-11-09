require 'spec_helper'

describe Glass do
  describe "validations" do
    it {expect(subject).to validate_presence_of(:name)}
    it {expect(subject).to validate_presence_of(:img_url)}
  end

  describe "associations" do
    it {expect(subject).to have_many(:drinks)}
  end
end
