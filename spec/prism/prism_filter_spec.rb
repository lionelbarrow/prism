require 'spec_helper'

describe PrismFilter do
  describe "allow?" do
    it "is true for stack frames unrelated this library" do
      stack_frame = StackFrame.new("call", "test.rb", 14, "disable!", "binding", "TestClass")
      PrismFilter.allow?(stack_frame).should be_true
    end

    it "is false for classes is false for stack frames related to this library" do
      ["RSpecController", "StackTraceGenerator", "Core"].each do |classname|
        stack_frame = StackFrame.new("call", "test.rb", 14, "disable!", "binding", classname)
        PrismFilter.allow?(stack_frame).should be_false
      end
    end

    it "it is false for stack frames from the stack_trace_generator file" do
      stack_frame = StackFrame.new("call", "stack_trace_generator.rb", 14, "disable!", "binding", nil)
      PrismFilter.allow?(stack_frame).should be_false
    end
  end
end
