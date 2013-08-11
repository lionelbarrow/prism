require 'spec_helper'

describe RSpecStackTraceGenerator do
  before(:each) do
    stub_rspec_example_groups
  end

  after(:each) do
    restore_rspec_example_groups
  end

  describe "stack_trace" do
    it "produces a log of events generated by a test" do
      tracer = RSpecStackTraceGenerator.new

      trace = tracer.stack_trace do
        example_group = RSpec::Core::ExampleGroup.describe("my favorite class")
        example_group.example("foos the bar") do
          object = TestClass.new
          object.invoke_a_method
        end
        example_group.run
      end

      trace.should_not be_empty
    end

    it "does not log invocations related to the stack trace generator" do
      tracer = RSpecStackTraceGenerator.new
      trace = tracer.stack_trace { }
      trace.should be_empty
    end

    it "does not log rspec-related set-up or invocations" do
      tracer = RSpecStackTraceGenerator.new

      trace = tracer.stack_trace do
        example_group = RSpec::Core::ExampleGroup.describe("my favorite class")
        example_group.example("foos the bar") do
        end
        example_group.run
      end

      (trace.length < 15).should be_true
    end
  end
end