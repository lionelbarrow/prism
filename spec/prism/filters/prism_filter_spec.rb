require 'spec_helper'

describe Prism::PrismFilter do
   before(:each) do
     @config = Prism::Configuration.new("prism", "diff")
   end

  describe "allow?" do
    it "is true for stack frames unrelated this library" do
      stack_frame = Prism::StackFrame.new(@config, "call", "test.rb", 14, "disable!", "binding", "TestClass")
      Prism::PrismFilter.allow?(stack_frame).should be_true
    end

    it "is false for classes is false for stack frames related to this library" do
      ["RSpecController", "StackTraceGenerator", "Core"].each do |classname|
        stack_frame = Prism::StackFrame.new(@config, "call", "test.rb", 14, "disable!", "binding", classname)
        Prism::PrismFilter.allow?(stack_frame).should be_false
      end
    end

    it "it is false for stack frames from the stack_trace_generator file" do
      stack_frame = Prism::StackFrame.new(@config, "call", "stack_trace_generator.rb", 14, "disable!", "binding", nil)
      Prism::PrismFilter.allow?(stack_frame).should be_false
    end
  end
end
