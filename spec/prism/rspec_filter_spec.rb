require 'spec_helper'

describe RSpecFilter do
  describe "allow?" do
    it "is false for rspec related stack frames"
    it "is true for other stack frames"
  end
end
