require "spec_helper"

describe Subtracter do
  describe "subtract" do
    it "it returns the first input minus the second input" do
      Subtracter.subtract(5, 4).should == 1
    end
  end
end
