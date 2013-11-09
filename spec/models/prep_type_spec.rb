require 'spec_helper'

describe PrepType do
  describe "associations" do
    it {expect(subject).to have_many(:drinks)}
  end
end
