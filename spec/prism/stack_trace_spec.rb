require "spec_helper"

describe Prism::StackTrace do
  describe "self.unique_identifier_for_group" do
    it "returns the file and line number of the test" do
      example_group = RSpec::Core::ExampleGroup.describe("my favorite class")
      example_group.example("foos the bar") do
        object = TestClass.new
        object.invoke_a_method
      end

      Prism::StackTrace.location_of_group(example_group).should == "spec/prism/stack_trace_spec.rb:6"
    end
  end
end
