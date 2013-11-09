require 'spec_helper'

describe Component do
  describe "associations" do
    it {expect(subject).to belong_to(:drink)}
    it {expect(subject).to belong_to(:ingredient)}
  end
end
