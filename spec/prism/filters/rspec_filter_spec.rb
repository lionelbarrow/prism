require 'spec_helper'

describe Prism::RSpecFilter do
  before(:each) do
    @config = Prism::Configuration.new("prism", "diff")
  end

  describe "allow?" do
    it "is true for stack frames unrelated to the test setup" do
      stack_frame = Prism::StackFrame.new(@config, "call", "test.rb", 14, "disable!", "binding", "StackTraceGenerator")
      Prism::RSpecFilter.allow?(stack_frame).should be_true
    end

    it "is false for stack frames from the RSpec::Core classes" do
      stack_frame = Prism::StackFrame.new(@config, "call", "test.rb", 14, "disable!", "binding", "RSpec::Core::Configuration")
      Prism::RSpecFilter.allow?(stack_frame).should be_false

      stack_frame = Prism::StackFrame.new(@config, "call", "test.rb", 14, "disable!", "binding", "RSpec::Core::ExampleGroup")
      Prism::RSpecFilter.allow?(stack_frame).should be_false
    end

    it "it is false for stack frames with the rspec-core file" do
      stack_frame = Prism::StackFrame.new(@config, "call", "/gems/rspec-core-2.13.1/lib/rspec/core/example_group.rb", 14, "disable!", "binding", nil)
      Prism::RSpecFilter.allow?(stack_frame).should be_false
    end

    it "it is false for stack frames with the rspec-mocks file" do
      stack_frame = Prism::StackFrame.new(@config, "call", "/gems/rspec-mocks-2.13.1/lib/rspec/mocks.rb", 14, "disable!", "binding", nil)
      Prism::RSpecFilter.allow?(stack_frame).should be_false
    end

    it "it is false for stack frames with the rspec-expectations file" do
      stack_frame = Prism::StackFrame.new(@config, "call", "/gems/rspec-expectations-2.13.1/lib/rspec/matchers/generated_descriptions.rb", 14, "disable!", "binding", nil)
      Prism::RSpecFilter.allow?(stack_frame).should be_false
    end
  end
end
