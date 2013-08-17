require 'spec_helper'

describe RSpecFilter do
  describe "allow?" do
    it "is true for stack frames unrelated to the test setup" do
      stack_frame = StackFrame.new("call", "test.rb", 14, "disable!", "binding", "StackTraceGenerator")
      RSpecFilter.allow?(stack_frame).should be_true
    end

    it "is false for stack frames from the RSpec::Core classes" do
      stack_frame = StackFrame.new("call", "test.rb", 14, "disable!", "binding", "RSpec::Core::Configuration")
      RSpecFilter.allow?(stack_frame).should be_false

      stack_frame = StackFrame.new("call", "test.rb", 14, "disable!", "binding", "RSpec::Core::ExampleGroup")
      RSpecFilter.allow?(stack_frame).should be_false
    end

    it "it is false for stack frames with the rspec-core file" do
      stack_frame = StackFrame.new("call", "/gems/rspec-core-2.13.1/lib/rspec/core/example_group.rb", 14, "disable!", "binding", nil)
      RSpecFilter.allow?(stack_frame).should be_false
    end

    it "it is false for stack frames with the rspec-mocks file" do
      stack_frame = StackFrame.new("call", "/gems/rspec-mocks-2.13.1/lib/rspec/mocks.rb", 14, "disable!", "binding", nil)
      RSpecFilter.allow?(stack_frame).should be_false
    end

    it "it is false for stack frames with the rspec-expectations file" do
      stack_frame = StackFrame.new("call", "/gems/rspec-expectations-2.13.1/lib/rspec/matchers/generated_descriptions.rb", 14, "disable!", "binding", nil)
      RSpecFilter.allow?(stack_frame).should be_false
    end
  end
end
