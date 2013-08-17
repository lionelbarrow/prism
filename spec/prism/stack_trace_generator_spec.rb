require 'spec_helper'

describe Prism::StackTraceGenerator do
  describe "enable!" do
    it "turns on the trace function" do
      object = TestClass.new
      tracer = Prism::StackTraceGenerator.new

      tracer.enable!
      object.invoke_a_method

      tracer.disable!
      tracer.stack_frames.should_not be_empty
    end
  end

  describe "disable!" do
    it "disables the trace function" do
      object = TestClass.new
      tracer = Prism::StackTraceGenerator.new
      tracer.enable!
      object.invoke_a_method

      tracer.disable!
      current_stack_size = tracer.stack_frames.length
      object.invoke_a_method

      tracer.stack_frames.length.should == current_stack_size
    end
  end

  describe "stack_trace" do
    it "produces a log of events generated by a method call" do
      tracer = Prism::StackTraceGenerator.new
      object = TestClass.new

      stack_trace = tracer.stack_trace { object.invoke_a_method }

      stack_trace.any? do |frame|
        if frame.id.nil?
          false
        else
          frame.id[/invoke_a_method/].nil?
        end
      end.should be_true
    end

    it "applies filters to the stack trace" do
      tracer = Prism::StackTraceGenerator.new(BadFilter)
      object = TestClass.new

      stack_trace = tracer.stack_trace { object.invoke_bad_method }

      stack_trace.each do |frame|
        BadFilter.allow?(frame).should be_true
      end
    end

    it "includes every stack frame if no filters are present" do
      tracer = Prism::StackTraceGenerator.new
      object = TestClass.new

      stack_trace = tracer.stack_trace { object.invoke_bad_method }

      stack_trace.length.should_not == 0
    end
  end

  describe "initialize" do
    it "adds the filters to the tracer" do
      tracer = Prism::StackTraceGenerator.new(BadFilter)
      tracer.filters.length.should == 1
    end

    it "accepts a variable number of arguments" do
      tracer = Prism::StackTraceGenerator.new(BadFilter, BadFilter)
      tracer.filters.length.should == 2
    end
  end
end
