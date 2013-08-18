require "spec_helper"

describe Adder do
  describe "add" do
    it "returns the two inputs added together" do
      Adder.add(5, 4).should == 9
    end
  end
end
