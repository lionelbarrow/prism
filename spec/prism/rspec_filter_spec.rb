require 'spec_helper'

describe RSpecFilter do
  describe "allow?" do
    # before(:each) do
    #   @tracer = StackTraceGenerator.new
    #   @tracer.enable!
    # end

    # after(:each) do
    #   @tracer.disable!
    # end

    it "is true for stack frames unrelated to the test setup"

    it "is false for stack frames related to the test setup"
  end
end
